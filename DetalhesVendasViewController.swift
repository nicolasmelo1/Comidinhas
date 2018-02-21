//
//  DetalhesVendasViewController.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 21/6/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class DetalhesVendasViewController: UIViewController, UIImagePickerControllerDelegate, UIScrollViewDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    @IBOutlet var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    
    @IBOutlet var botaoSalvar: UIBarButtonItem!
    @IBOutlet var nomeComidinha: UITextField!
    
    let descricaoText = UITextView()
    let descricao = UILabel()
    let precoLabel = UILabel()
    let preco = UITextField()
    let doceOuSalgadoImage = UIImageView()
    let doceOuSalgado = UISwitch()
    let repeticaoOuNao = UISwitch()
    let veganoOuNVeganoImage = UIImageView()
    let veganoOuNVegano = UISwitch()
    let manhaLabel = UILabel()
    let tardeLabel = UILabel()
    let noiteLabel = UILabel()
    var manhaView = UIView()
    var tardeView = UIView()
    var noiteView = UIView()
    
    let repetir = UILabel()
    var domingoView = UIView()
    var segundaView = UIView()
    var tercaView = UIView()
    var quartaView = UIView()
    var quintaView = UIView()
    var sextaView = UIView()
    var sabadoView = UIView()
    var domingoLabel = UILabel()
    var segundaLabel = UILabel()
    var tercaLabel = UILabel()
    var quartaLabel = UILabel()
    var quintaLabel = UILabel()
    var sextaLabel = UILabel()
    var sabadoLabel = UILabel()
    
    
    var firstImage = UIImage()
    
    
    //MARK: Variables
    var isRepeticao: Bool?
    var isSegunda: String?
    var isTerca: String?
    var isQuarta: String?
    var isQuinta: String?
    var isSexta: String?
    var isSabado: String?
    var isDomingo: String?
    
    var isManha: String?
    var isTarde: String?
    var isNoite: String?
    var nomeProdutoVendas: String?
    var precoLabelVendas: String?
    var veganoVendas: String?
    var salgadoOuDoceVendas: String?
    
    
    var swipeRightToDelete = UISwipeGestureRecognizer()
    var venda: Vendas?
    var verificaSeTemImagem = false
    let picker = UIImagePickerController()
    weak var tappedImage = UIImageView()
    var deleteImageLabel = UILabel()
    var deleteImageButton = UIButton()
    var editImageButton = UIButton()
    var scrollImage = UIScrollView()
    var imageArray: Array<Any> = []
    var newImageArray: Array<Any> = []
    var isDelete = false
    var isEditImage = false
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if (nomeComidinha.text == "" || preco.text == "0.00"){
            let alert = UIAlertController(title: "VISH!", message: "Resolve o problema ai parça, ta sem nome ou preço.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard let button = sender as? UIBarButtonItem, button === botaoSalvar else {
            return
        }
        //MARK: Caso os dados estejam vazios e não tenham sido selecionados, atribuimos valores a fim de evitar possiveis erros.
        if (self.isSegunda == nil){
            self.isSegunda = "false"
        }
        if (self.isTerca == nil){
            self.isTerca = "false"
        }
        if (self.isQuarta == nil){
            self.isQuarta = "false"
        }
        if (self.isQuinta == nil){
            self.isQuinta = "false"
        }
        if (self.isSexta == nil){
            self.isSexta = "false"
        }
        if (self.isSabado == nil){
            self.isSabado = "false"
        }
        if (self.isDomingo == nil){
            self.isDomingo = "false"
        }
        
        if (self.isManha == nil) {
            self.isManha = "false"
        }
        if (self.isTarde == nil){
            self.isTarde = "false"
        }
        if (self.isNoite == nil){
            self.isNoite = "false"
        }
        if (self.isRepeticao == nil){
            self.isRepeticao = false
        }
        if (self.veganoVendas?.isEmpty)!{
            self.veganoVendas = "false"
        }
        if (self.salgadoOuDoceVendas?.isEmpty)!{
            self.salgadoOuDoceVendas = "salgado"
        }
        
        
        let isManha = self.isManha
        let isTarde = self.isTarde
        let isNoite = self.isNoite
        let nomeProdutoVendas = nomeComidinha.text
        let precoLabelVendas = "R$" + (preco.text?.replacingOccurrences(of: ".", with: ","))!
        let veganoVendas = self.veganoVendas
        let salgadoOuDoceVendas = self.salgadoOuDoceVendas
        
        
        venda = Vendas(isSegunda: isSegunda!, isTerca: isTerca!, isQuarta: isQuarta!,
                       isQuinta: isQuinta!, isSexta: isSexta!, isSabado: isSabado!, isDomingo: isDomingo!, isRepeticao: isRepeticao!,
                        isManha: isManha!,  isTarde: isTarde!, isNoite: isNoite!,
                       unidadesVendidas: "200 Unidades Vendidas",
                       nomeProdutoVendas: nomeProdutoVendas!,
                       imagemProdutoVendas: UIImage(named:"Logo")!,
                       precoLabelVendas: precoLabelVendas,
                       veganoImagemVendas: veganoVendas!,
                       salgadoOuDoceImagemVendas: salgadoOuDoceVendas!)
        
    }
    
    
    @IBAction func returnKeyPressedOnTitle(_ sender: Any) {
        self.nomeComidinha.endEditing(true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        scrollImage.showsHorizontalScrollIndicator = false
        scrollImage.showsVerticalScrollIndicator = false
        self.nomeComidinha.delegate = self
        picker.delegate = self
        picker.navigationBar.barTintColor = #colorLiteral(red: 0.3230314553, green: 0.4958537817, blue: 0.5499756932, alpha: 1)
        preco.delegate = self
        self.scrollView.delegate = self

        if nomeProdutoVendas != nil {
            nomeComidinha.text = nomeProdutoVendas
        }
        if precoLabelVendas != nil {
            let newString = precoLabelVendas?.replacingOccurrences(of: "R$", with: "")
            preco.text = newString?.replacingOccurrences(of: ",", with: ".")
        }else{
            preco.text = "0.00"
        }
        if verificaSeTemImagem == false {
            firstImage = #imageLiteral(resourceName: "Logo")
            definirview(imageArray: [firstImage])
        }
        self.hideKeyboardWhenTappedAround()
    }
    
    
    
    
    func definirview(imageArray: Array<UIImage>) {
        
        
        
        
        
        
        nomeComidinha.textColor = UIColor.white
        nomeComidinha.textAlignment = .center
        nomeComidinha.backgroundColor = #colorLiteral(red: 0.615627408, green: 0.6043154597, blue: 0.5780405402, alpha: 1)
        
        
        manhaLabel.text = "Manhã"
        tardeLabel.text = "Tarde"
        noiteLabel.text = "Noite"
        
        
        
        domingoLabel.text = "D"
        segundaLabel.text = "S"
        tercaLabel.text = "T"
        quartaLabel.text = "Q"
        quintaLabel.text = "Q"
        sextaLabel.text = "S"
        sabadoLabel.text = "S"
        
        
        let scrollViewTap = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        scrollViewTap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(scrollViewTap)
        
        
        
        manhaView.frame = CGRect (x: ((self.scrollView.frame.width/3)/2) - ((self.scrollView.frame.width/4)/2), y: 10, width:self.scrollView.frame.width/4, height: self.scrollView.frame.width/4)
        manhaView.layer.borderWidth = 3
        manhaView.layer.borderColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1).cgColor
        manhaView.layer.cornerRadius = self.manhaView.frame.size.width/2
        
        
        
        tardeView.frame = CGRect (x: (self.scrollView.frame.width/2) - ((self.scrollView.frame.width/4)/2), y: 10, width:self.scrollView.frame.width/4, height: self.scrollView.frame.width/4)
        tardeView.layer.borderWidth = 3
        tardeView.layer.borderColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1).cgColor
        tardeView.layer.cornerRadius = self.manhaView.frame.size.width/2
        
        noiteView.frame = CGRect (x: self.scrollView.frame.width - ((self.scrollView.frame.width/3)/2) - ((self.scrollView.frame.width/4)/2) , y: 10, width:self.scrollView.frame.width/4, height: self.scrollView.frame.width/4)
        noiteView.layer.borderWidth = 3
        noiteView.layer.borderColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1).cgColor
        noiteView.layer.cornerRadius = self.manhaView.frame.size.width/2
        
        
        manhaLabel.frame = CGRect (x: 0, y:0, width: self.manhaView.frame.width, height: self.manhaView.frame.height)
        manhaLabel.textAlignment = .center
        manhaLabel.textColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
        
        tardeLabel.frame = CGRect (x: 0, y:0, width: self.tardeView.frame.width, height: self.tardeView.frame.height)
        tardeLabel.textAlignment = .center
        tardeLabel.textColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1)
        
        noiteLabel.frame = CGRect (x: 0, y:0, width: self.noiteView.frame.width, height: self.noiteView.frame.height)
        noiteLabel.textAlignment = .center
        noiteLabel.textColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1)
        
        if isManha != nil{
            if (isManha == "true"){
                self.manhaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            } else if (isManha == "false") {
                self.manhaView.backgroundColor = UIColor.clear
            }
        }
        if isTarde != nil {
            if (isTarde == "true"){
                self.tardeView.backgroundColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1)
            } else if (isTarde == "false") {
                self.tardeView.backgroundColor = UIColor.clear
            }
        }
        if isNoite != nil {
            
            if (isNoite == "true"){
                self.noiteView.backgroundColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1)
            } else if (isNoite == "false") {
                self.noiteView.backgroundColor = UIColor.clear
            }
        }
        
        manhaView.addSubview(manhaLabel)
        tardeView.addSubview(tardeLabel)
        noiteView.addSubview(noiteLabel)
        
        
        
        
        
        
        let tapGestureRecognizerManha = UITapGestureRecognizer(target: self, action: #selector(manhaTapped(tapGestureRecognizerManha:)))
        manhaView.isUserInteractionEnabled = true
        manhaView.addGestureRecognizer(tapGestureRecognizerManha)
        
        let tapGestureRecognizerTarde = UITapGestureRecognizer(target: self, action: #selector(tardeTapped(tapGestureRecognizerTarde:)))
        tardeView.isUserInteractionEnabled = true
        tardeView.addGestureRecognizer(tapGestureRecognizerTarde)
        
        let tapGestureRecognizerNoite = UITapGestureRecognizer(target: self, action: #selector(noiteTapped(tapGestureRecognizerNoite:)))
        noiteView.isUserInteractionEnabled = true
        noiteView.addGestureRecognizer(tapGestureRecognizerNoite)
        
        
        
        
        
        scrollImage.frame = CGRect(x: 0, y: self.tardeView.frame.height + 25, width: self.scrollView.frame.width, height: self.scrollView.frame.height/2.5)
        scrollImage.isPagingEnabled = true
        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            let longGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imageHold(longGestureRecognizer:)))
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
            imageView.addGestureRecognizer(longGestureRecognizer)
            
            
        
            imageView.contentMode = .scaleAspectFill
            let Position = self.scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect (x: Position, y: 0, width: self.scrollView.frame.width, height: self.scrollImage.frame.height)
            //imageView.layer.cornerRadius = self.imageView.frame.size.width/2
            
            
            scrollImage.contentSize.width = scrollImage.frame.width * CGFloat(i + 1)
            
            
            
            scrollImage.addSubview(imageView)
        }
        //scrollImage.layer.cornerRadius = self.scrollImage.frame.size.height/2
        
        
        deleteImageButton.frame = CGRect (x: self.scrollView.frame.width/2 - 25, y: self.scrollImage.frame.height/2 + self.tardeView.frame.height, width: 50, height: 50)
        deleteImageButton.layer.borderWidth = 2
        deleteImageButton.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1).cgColor
        deleteImageButton.layer.cornerRadius = self.deleteImageButton.frame.size.width/2
        deleteImageButton.isEnabled = false
        deleteImageButton.alpha = 0.0
        
        deleteImageLabel.frame = CGRect (x: 0, y:0, width: self.deleteImageButton.frame.width, height: self.deleteImageButton.frame.height)
        deleteImageLabel.textAlignment = .center
        deleteImageLabel.text = "X"
        deleteImageLabel.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        deleteImageButton.addSubview(deleteImageLabel)
        
        editImageButton.frame = CGRect (x: self.scrollView.frame.width/2 - 25, y: self.scrollImage.frame.height/2 + self.tardeView.frame.height, width: 50, height: 50)
        editImageButton.layer.borderWidth = 2
        editImageButton.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        editImageButton.layer.cornerRadius = self.deleteImageButton.frame.size.width/2
        editImageButton.isEnabled = false
        editImageButton.alpha = 0.0
        editImageButton.setImage(#imageLiteral(resourceName: "Edit"), for: [])
        
        
        precoLabel.frame = CGRect(x:0, y: 0, width: 25, height: 30)
        precoLabel.textColor = #colorLiteral(red: 0.3588529825, green: 0.5504949689, blue: 0.6134560704, alpha: 1)
        precoLabel.font = precoLabel.font.withSize(20)
        precoLabel.text = "R$"
        
        
        preco.frame = CGRect(x:(self.scrollView.frame.width/3), y: self.tardeView.frame.height + self.scrollImage.frame.height + 35, width: self.scrollView.frame.width/2.8, height: 70)
        preco.textAlignment = .right
        preco.font = UIFont (name: (preco.font?.fontName)!, size: 40)
        preco.textColor = #colorLiteral(red: 0.3588529825, green: 0.5504949689, blue: 0.6134560704, alpha: 1)
        preco.keyboardType = UIKeyboardType.numberPad
        preco.leftViewMode = UITextFieldViewMode.always
        preco.leftView = precoLabel
        
        
        doceOuSalgadoImage.frame = CGRect (x: ((self.scrollView.frame.width/2)/2)+60, y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + 55, width: 20, height: 20)
        
        
        doceOuSalgado.frame = CGRect (x: ((self.scrollView.frame.width/2)/2), y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + 50, width: self.scrollView.frame.width, height: 20)
        if salgadoOuDoceVendas != nil {
            if (salgadoOuDoceVendas == "salgado"){
                doceOuSalgado.isOn = true
                doceOuSalgado.onTintColor = #colorLiteral(red: 0.3230314553, green: 0.4958537817, blue: 0.5499756932, alpha: 1)
                doceOuSalgadoImage.image = #imageLiteral(resourceName: "Salgado")
            } else {
                doceOuSalgado.isOn = false
                doceOuSalgado.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                doceOuSalgadoImage.image = #imageLiteral(resourceName: "Comidinhas não Selecionado")
            }
        }else{
            salgadoOuDoceVendas = "salgado"
            doceOuSalgado.isOn = false
            doceOuSalgado.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            doceOuSalgadoImage.image = #imageLiteral(resourceName: "Comidinhas não Selecionado")
        }
        doceOuSalgado.addTarget(self, action: #selector(doceOuSalgadoChanged(switchState:)), for: UIControlEvents.valueChanged)
        
        
        
        
        
        veganoOuNVeganoImage.frame = CGRect (x: ((self.scrollView.frame.width/2)+45)-30, y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + 55, width: 20, height: 20)
        
        veganoOuNVegano.frame = CGRect (x: ((self.scrollView.frame.width/2))+45, y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + 50, width: self.scrollView.frame.width, height: 20)
        
        if veganoVendas != nil {
            if (veganoVendas == "true"){
                veganoOuNVeganoImage.image = #imageLiteral(resourceName: "Vegano")
                veganoOuNVegano.isOn = true
                veganoOuNVegano.onTintColor = #colorLiteral(red: 0.3230314553, green: 0.4958537817, blue: 0.5499756932, alpha: 1)
            } else {
                
                veganoOuNVeganoImage.image = nil
                veganoOuNVegano.isOn = false
                veganoOuNVegano.onTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        } else {
            veganoVendas = "false"
            veganoOuNVeganoImage.image = nil
            veganoOuNVegano.isOn = false
            veganoOuNVegano.onTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        veganoOuNVegano.addTarget(self, action: #selector(veganoOuNVeganoChanged(switchState:)), for: UIControlEvents.valueChanged)
        
        
        
        
        
        descricao.frame = CGRect(x:0, y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + 90, width: self.scrollView.frame.width, height: 20)
        descricao.textAlignment = .center
        descricao.textColor = #colorLiteral(red: 0.3588529825, green: 0.5504949689, blue: 0.6134560704, alpha: 1)
        descricao.text = "Descrição"
        
        descricaoText.frame = CGRect(x:0, y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + 90, width: self.scrollView.frame.width, height: 300)
        descricaoText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In dui leo, pulvinar sed bibendum sit amet, molestie ut mauris. Suspendisse non diam lorem. Duis nulla dui, viverra euismod lacinia sed, interdum fermentum tellus. Quisque tincidunt ligula sit amet convallis vehicula. Proin in eleifend est, sed faucibus urna. Proin sodales porttitor metus sit amet maximus. Aliquam id pellentesque nibh. Maecenas gravida dignissim lectus eu condimentum. Pellentesque vel nisl orci. Morbi porttitor mi lacus, sit amet condimentum ligula dignissim a. Quisque ante tortor, eleifend in auctor non, mollis at massa. Aliquam eu justo sed sem volutpat tempor sit amet eget nunc. Sed tempor diam at lorem lobortis scelerisque. Sed in ullamcorper ex. Aenean consequat lectus risus, in euismod est vestibulum a. Fusce fringilla ornare ligula, a facilisis purus porttitor eget. Integer sit amet mattis nisi. Ut id velit vel eros tincidunt luctus. Fusce vulputate, augue quis consectetur egestas, dolor quam tincidunt enim, vitae pretium erat magna eget neque. Praesent fermentum non purus ut eleifend. Ut condimentum ligula et est facilisis, a sodales lectus finibus."
        
        descricaoText.font = UIFont (name:(descricaoText.font?.fontName)!, size: 15)
        
        
        
        
        
        repetir.textAlignment = .center
        repetir.textColor = #colorLiteral(red: 0.3588529825, green: 0.5504949689, blue: 0.6134560704, alpha: 1)
        repetir.frame = CGRect(x:0, y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 120, width: self.scrollView.frame.width, height: 20)
        
        
        
        repeticaoOuNao.frame = CGRect(x:(self.scrollView.frame.width/2)-(self.repeticaoOuNao.frame.width/2), y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 150, width: 40, height: 20)
        
    
        
        
        domingoView.frame = CGRect (x: (self.scrollView.frame.width/8) - ((self.scrollView.frame.width/9)/2) , y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 150, width:self.scrollView.frame.width/9, height: self.scrollView.frame.width/9)
        domingoView.layer.borderWidth = 1
        domingoView.layer.borderColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1).cgColor
        domingoView.layer.cornerRadius = self.domingoView.frame.size.width/2
        
        domingoLabel.frame = CGRect (x: 0, y:0, width: self.domingoView.frame.width, height: self.domingoView.frame.height)
        domingoLabel.textAlignment = .center
        domingoLabel.textColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
        
        segundaView.frame = CGRect (x: (self.scrollView.frame.width/4)-((self.scrollView.frame.width/9)/2), y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 150, width:self.scrollView.frame.width/9, height: self.scrollView.frame.width/9)
        segundaView.layer.borderWidth = 1
        segundaView.layer.borderColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1).cgColor
        segundaView.layer.cornerRadius = self.segundaView.frame.size.width/2
        
        segundaLabel.frame = CGRect (x: 0, y:0, width: self.segundaView.frame.width, height: self.segundaView.frame.height)
        segundaLabel.textAlignment = .center
        segundaLabel.textColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
        
        
        tercaView.frame = CGRect (x: (self.scrollView.frame.width/2)-(self.scrollView.frame.width/8)-((self.scrollView.frame.width/9)/2), y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 150, width:self.scrollView.frame.width/9, height: self.scrollView.frame.width/9)
        tercaView.layer.borderWidth = 1
        tercaView.layer.borderColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1).cgColor
        tercaView.layer.cornerRadius = self.tercaView.frame.size.width/2
        
        tercaLabel.frame = CGRect (x: 0, y:0, width: self.tercaView.frame.width, height: self.tercaView.frame.height)
        tercaLabel.textAlignment = .center
        tercaLabel.textColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
        
        
        quartaView.frame = CGRect (x: (self.scrollView.frame.width/2)-((self.scrollView.frame.width/9)/2), y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 150, width:self.scrollView.frame.width/9, height: self.scrollView.frame.width/9)
        quartaView.layer.borderWidth = 1
        quartaView.layer.borderColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1).cgColor
        quartaView.layer.cornerRadius = self.quartaView.frame.size.width/2
        
        quartaLabel.frame = CGRect (x: 0, y:0, width: self.quartaView.frame.width, height: self.quartaView.frame.height)
        quartaLabel.textAlignment = .center
        quartaLabel.textColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
        
        
        quintaView.frame = CGRect (x: (self.scrollView.frame.width/2)+(self.scrollView.frame.width/8)-((self.scrollView.frame.width/9)/2), y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 150, width:self.scrollView.frame.width/9, height: self.scrollView.frame.width/9)
        quintaView.layer.borderWidth = 1
        quintaView.layer.borderColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1).cgColor
        quintaView.layer.cornerRadius = self.quintaView.frame.size.width/2
        
        quintaLabel.frame = CGRect (x: 0, y:0, width: self.quintaView.frame.width, height: self.quintaView.frame.height)
        quintaLabel.textAlignment = .center
        quintaLabel.textColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
        
        
        sextaView.frame = CGRect (x: (self.scrollView.frame.width/4)*3-((self.scrollView.frame.width/9)/2), y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 150, width:self.scrollView.frame.width/9, height: self.scrollView.frame.width/9)
        sextaView.layer.borderWidth = 1
        sextaView.layer.borderColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1).cgColor
        sextaView.layer.cornerRadius = self.sextaView.frame.size.width/2
        
        sextaLabel.frame = CGRect (x: 0, y:0, width: self.sextaView.frame.width, height: self.sextaView.frame.height)
        sextaLabel.textAlignment = .center
        sextaLabel.textColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
    
        
        sabadoView.frame = CGRect (x: self.scrollView.frame.width - (self.scrollView.frame.width/8) - ((self.scrollView.frame.width/9)/2) , y: self.tardeView.frame.height + self.scrollImage.frame.height + self.preco.frame.height + self.doceOuSalgado.frame.height + self.descricao.frame.height + self.descricaoText.frame.height + 150, width:self.scrollView.frame.width/9, height: self.scrollView.frame.width/9)
        sabadoView.layer.borderWidth = 1
        sabadoView.layer.borderColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1).cgColor
        sabadoView.layer.cornerRadius = self.sabadoView.frame.size.width/2
        
        sabadoLabel.frame = CGRect (x: 0, y:0, width: self.sabadoView.frame.width, height: self.sabadoView.frame.height)
        sabadoLabel.textAlignment = .center
        sabadoLabel.textColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
        
        if isRepeticao == false {
            repeticaoOuNao.isOn = false
            repetir.text = "Sem Repetição"
            repeticaoOuNao.onTintColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            segundaView.alpha=0.0
            tercaView.alpha=0.0
            quartaView.alpha=0.0
            quintaView.alpha=0.0
            sextaView.alpha=0.0
            sabadoView.alpha=0.0
            domingoView.alpha=0.0
            
        } else {
            repeticaoOuNao.isOn = true
            repetir.text = "Repetição"
            repeticaoOuNao.onTintColor = #colorLiteral(red: 0.3588529825, green: 0.5504949689, blue: 0.6134560704, alpha: 1)
            segundaView.frame.origin.y += 50
            tercaView.frame.origin.y += 50
            quartaView.frame.origin.y += 50
            quintaView.frame.origin.y += 50
            sextaView.frame.origin.y += 50
            sabadoView.frame.origin.y += 50
            domingoView.frame.origin.y += 50
            
            segundaView.alpha=1.0
            tercaView.alpha=1.0
            quartaView.alpha=1.0
            quintaView.alpha=1.0
            sextaView.alpha=1.0
            sabadoView.alpha=1.0
            domingoView.alpha=1.0
            
        }
        repeticaoOuNao.addTarget(self, action: #selector(repetirOuNaoChanged(switchState:)), for: UIControlEvents.valueChanged)
        
        
        let tapGestureRecognizerSegunda = UITapGestureRecognizer(target: self, action: #selector(segundaTapped(tapGestureRecognizerSegunda:)))
        segundaView.isUserInteractionEnabled = true
        segundaView.addGestureRecognizer(tapGestureRecognizerSegunda)
        
        let tapGestureRecognizerTerca = UITapGestureRecognizer(target: self, action: #selector(tercaTapped(tapGestureRecognizerTerca:)))
        tercaView.isUserInteractionEnabled = true
        tercaView.addGestureRecognizer(tapGestureRecognizerTerca)
        
        let tapGestureRecognizerQuarta = UITapGestureRecognizer(target: self, action: #selector(quartaTapped(tapGestureRecognizerQuarta:)))
        quartaView.isUserInteractionEnabled = true
        quartaView.addGestureRecognizer(tapGestureRecognizerQuarta)
        
        let tapGestureRecognizerQuinta = UITapGestureRecognizer(target: self, action: #selector(quintaTapped(tapGestureRecognizerQuinta:)))
        quintaView.isUserInteractionEnabled = true
        quintaView.addGestureRecognizer(tapGestureRecognizerQuinta)
        
        let tapGestureRecognizerSexta = UITapGestureRecognizer(target: self, action: #selector(sextaTapped(tapGestureRecognizerSexta:)))
        sextaView.isUserInteractionEnabled = true
        sextaView.addGestureRecognizer(tapGestureRecognizerSexta)
        
        let tapGestureRecognizerSabado = UITapGestureRecognizer(target: self, action: #selector(sabadoTapped(tapGestureRecognizerSabado:)))
        sabadoView.isUserInteractionEnabled = true
        sabadoView.addGestureRecognizer(tapGestureRecognizerSabado)
        
        let tapGestureRecognizerDomingo = UITapGestureRecognizer(target: self, action: #selector(domingoTapped(tapGestureRecognizerDomingo:)))
        domingoView.isUserInteractionEnabled = true
        domingoView.addGestureRecognizer(tapGestureRecognizerDomingo)
        
        
        
        if isSegunda != nil{
            if (isSegunda == "true"){
                self.segundaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            } else if (isSegunda == "false") {
                self.segundaView.backgroundColor = UIColor.clear
            }
        }
        if isTerca != nil {
            if (isTerca == "true"){
                self.tercaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            } else if (isTerca == "false") {
                self.tercaView.backgroundColor = UIColor.clear
            }
        }
        if isQuarta != nil {
            
            if (isQuarta == "true"){
                self.quartaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            } else if (isQuarta == "false") {
                self.quartaView.backgroundColor = UIColor.clear
            }
        }
        if isQuinta != nil {
            
            if (isQuinta == "true"){
                self.quintaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            } else if (isQuinta == "false") {
                self.quintaView.backgroundColor = UIColor.clear
            }
        }
        if isSexta != nil {
            
            if (isSexta == "true"){
                self.sextaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            } else if (isSexta == "false") {
                self.sextaView.backgroundColor = UIColor.clear
            }
        }
        if isSabado != nil {
            
            if (isSabado == "true"){
                self.sabadoView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            } else if (isSabado == "false") {
                self.sabadoView.backgroundColor = UIColor.clear
            }
        }
        if isDomingo != nil {
            
            if (isDomingo == "true"){
                self.domingoView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            } else if (isDomingo == "false") {
                self.domingoView.backgroundColor = UIColor.clear
            }
        }
        
        
        
        
        
        domingoView.addSubview(domingoLabel)
        segundaView.addSubview(segundaLabel)
        tercaView.addSubview(tercaLabel)
        quartaView.addSubview(quartaLabel)
        quintaView.addSubview(quintaLabel)
        sextaView.addSubview(sextaLabel)
        sabadoView.addSubview(sabadoLabel)
        
        scrollView.contentSize.height = descricao.frame.height + descricaoText.frame.height + doceOuSalgado.frame.height + preco.frame.height + precoLabel.frame.height + scrollImage.frame.height + tardeView.frame.height + domingoView.frame.height + 200
        
        
        self.editImageButton.layer.zPosition = 1
        self.deleteImageButton.layer.zPosition = 1
        scrollView.insertSubview(editImageButton, aboveSubview: scrollImage)
        scrollView.insertSubview(deleteImageButton, aboveSubview: scrollImage)
        scrollView.addSubview(repeticaoOuNao)
        scrollView.addSubview(repetir)
        scrollView.addSubview(sabadoView)
        scrollView.addSubview(sextaView)
        scrollView.addSubview(quintaView)
        scrollView.addSubview(quartaView)
        scrollView.addSubview(tercaView)
        scrollView.addSubview(segundaView)
        scrollView.addSubview(domingoView)
        scrollView.addSubview(veganoOuNVeganoImage)
        scrollView.addSubview(veganoOuNVegano)
        scrollView.addSubview(doceOuSalgadoImage)
        scrollView.addSubview(doceOuSalgado)
        scrollView.addSubview(descricaoText)
        scrollView.addSubview(descricao)
        scrollView.addSubview(precoLabel)
        scrollView.addSubview(preco)
        scrollView.addSubview(manhaView)
        scrollView.addSubview(tardeView)
        scrollView.addSubview(noiteView)
        scrollView.addSubview(scrollImage)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == preco{
            var originalString = preco.text
            
            
            
            // Replace any formatting commas
            originalString = originalString!.replacingOccurrences(of: "," ,with: "")
            
            var doubleFromString:  Float!
            
            
            
            if originalString!.isEmpty {
                originalString = string
                doubleFromString = Float(originalString!)
                doubleFromString! /= 100
            } else {
                if string.isEmpty {
                    // Replace the last character for 0
                    let loc = originalString!.characters.count - 1
                    let range = NSMakeRange(loc, 1)
                    let newString = (originalString! as NSString).replacingCharacters(in: range, with: "0")
                    doubleFromString = Float(newString)
                    doubleFromString! /= 10
                } else {
                    originalString = originalString! + string
                    doubleFromString = Float(originalString!)
                    doubleFromString! *= 10
                }
                
            }
            
            let finalString = String(format: "%.2f" ,arguments:[doubleFromString])
            
            preco.text = finalString
            
            return false
        }
        return true
        
        
    }
    
    
    @objc func doceOuSalgadoChanged(switchState: UISwitch){
        
        if switchState.isOn {
            switchState.onTintColor = #colorLiteral(red: 0.3230314553, green: 0.4958537817, blue: 0.5499756932, alpha: 1)
            
            doceOuSalgadoImage.image = #imageLiteral(resourceName: "Salgado")
            salgadoOuDoceVendas = "salgado"
        } else {
            switchState.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            doceOuSalgadoImage.image = #imageLiteral(resourceName: "Comidinhas não Selecionado")
            salgadoOuDoceVendas = "doce"
        }
        
    }
    
    
    @objc func veganoOuNVeganoChanged(switchState: UISwitch){
        
        if switchState.isOn {
            switchState.onTintColor = #colorLiteral(red: 0.3230314553, green: 0.4958537817, blue: 0.5499756932, alpha: 1)
            
            veganoOuNVeganoImage.image = #imageLiteral(resourceName: "Vegano")
            veganoVendas = "true"
        } else {
            switchState.tintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            veganoOuNVeganoImage.image = nil
            veganoVendas = "false"
        }
        
    }
    
    
    @objc func repetirOuNaoChanged(switchState: UISwitch){
        
        if switchState.isOn {
            repetir.text = "Repetição"
            switchState.onTintColor = #colorLiteral(red: 0.3230314553, green: 0.4958537817, blue: 0.5499756932, alpha: 1)
            isRepeticao = true
            UIView.animate(withDuration: 0.1, animations: {
                self.domingoView.frame.origin.y += 50
                self.domingoView.alpha=1.0
            })
            UIView.animate(withDuration: 0.2, animations: {
                self.segundaView.frame.origin.y += 50
                self.segundaView.alpha=1.0
            })
            UIView.animate(withDuration: 0.3, animations: {
                self.tercaView.frame.origin.y += 50
                self.tercaView.alpha=1.0
            })
            UIView.animate(withDuration: 0.4, animations: {
                self.quartaView.frame.origin.y += 50
                self.quartaView.alpha=1.0
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.quintaView.frame.origin.y += 50
                self.quintaView.alpha=1.0
            })
            UIView.animate(withDuration: 0.6, animations: {
                self.sextaView.frame.origin.y += 50
                self.sextaView.alpha=1.0
            })
            UIView.animate(withDuration: 0.7, animations: {
                self.sabadoView.frame.origin.y += 50
                self.sabadoView.alpha=1.0
            })
        } else {
            repetir.text = "Sem Repetição"
            switchState.onTintColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            isRepeticao = false
            UIView.animate(withDuration: 0.1, animations: {
                self.domingoView.frame.origin.y -= 50
                self.domingoView.alpha=0.0
            })
            UIView.animate(withDuration: 0.2, animations: {
                self.segundaView.frame.origin.y -= 50
                self.segundaView.alpha=0.0
            })
            UIView.animate(withDuration: 0.3, animations: {
                self.tercaView.frame.origin.y -= 50
                self.tercaView.alpha=0.0
            })
            UIView.animate(withDuration: 0.4, animations: {
                self.quartaView.frame.origin.y -= 50
                self.quartaView.alpha=0.0
            })
            UIView.animate(withDuration: 0.5, animations: {
                self.quintaView.frame.origin.y -= 50
                self.quintaView.alpha=0.0
            })
            UIView.animate(withDuration: 0.6, animations: {
                self.sextaView.frame.origin.y -= 50
                self.sextaView.alpha=0.0
            })
            UIView.animate(withDuration: 0.7, animations: {
                self.sabadoView.frame.origin.y -= 50
                self.sabadoView.alpha=0.0
            })
        }
    }
    
    
    @objc func manhaTapped(tapGestureRecognizerManha: UITapGestureRecognizer){
        if isManha != nil {
            let trueOrFalse = isManha
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.manhaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isManha = "true"
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.manhaView.backgroundColor = UIColor.clear
                    self.isManha = "false"
                }, completion:nil)
            }
        } else {
            isManha = "false"
            let trueOrFalse = isManha
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.manhaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isManha = "true"
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.manhaView.backgroundColor = UIColor.clear
                    self.isManha = "false"
                }, completion:nil)
            }
        }
    }
    @objc func tardeTapped(tapGestureRecognizerTarde: UITapGestureRecognizer){
        if isTarde != nil {
            let trueOrFalse = isTarde
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.tardeView.backgroundColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1)
                    self.isTarde = "true"
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.tardeView.backgroundColor = UIColor.clear
                    self.isTarde = "false"
                }, completion:nil)
            }
        } else {
            isTarde = "false"
            let trueOrFalse = isTarde
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.tardeView.backgroundColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1)
                    self.isTarde = "true"
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                print ("Ué2")
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.tardeView.backgroundColor = UIColor.clear
                    self.isTarde = "false"
                }, completion:nil)
            }
        }
    }
    @objc func noiteTapped(tapGestureRecognizerNoite: UITapGestureRecognizer){
        if isNoite != nil {
            let trueOrFalse = isNoite
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.noiteView.backgroundColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1)
                    self.isNoite = "true"
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.noiteView.backgroundColor = UIColor.clear
                    self.isNoite = "false"
                }, completion:nil)
            }
        } else {
            isNoite = "false"
            let trueOrFalse = isNoite
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.noiteView.backgroundColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1)
                    self.isNoite = "true"
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.7, delay: 0.0, animations: {
                    self.noiteView.backgroundColor = UIColor.clear
                    self.isNoite = "false"
                }, completion:nil)
            }
        }
    }
    
    @objc func segundaTapped(tapGestureRecognizerSegunda: UITapGestureRecognizer){
        if isSegunda != nil {
            let trueOrFalse = isSegunda
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.segundaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isSegunda = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.segundaView.backgroundColor = UIColor.clear
                    self.isSegunda = "false"
                }, completion:nil)
            }
        } else {
            isSegunda = "false"
            let trueOrFalse = isSegunda
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.segundaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isSegunda = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.segundaView.backgroundColor = UIColor.clear
                    self.isSegunda = "false"
                }, completion:nil)
            }
        }
    }
    @objc func tercaTapped(tapGestureRecognizerTerca: UITapGestureRecognizer){
        if isTerca != nil {
            let trueOrFalse = isTerca
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.tercaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isTerca = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.tercaView.backgroundColor = UIColor.clear
                    self.isTerca = "false"
                }, completion:nil)
            }
        } else {
            isTerca = "false"
            let trueOrFalse = isTerca
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.tercaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isTerca = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.tercaView.backgroundColor = UIColor.clear
                    self.isTerca = "false"
                }, completion:nil)
            }
        }
    }
    @objc func quartaTapped(tapGestureRecognizerQuarta: UITapGestureRecognizer){
        if isQuarta != nil {
            let trueOrFalse = isQuarta
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.quartaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isQuarta = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.quartaView.backgroundColor = UIColor.clear
                    self.isQuarta = "false"
                }, completion:nil)
            }
        } else {
            isQuarta = "false"
            let trueOrFalse = isQuarta
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.quartaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isQuarta = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.quartaView.backgroundColor = UIColor.clear
                    self.isQuarta = "false"
                }, completion:nil)
            }
        }
    }
    @objc func quintaTapped(tapGestureRecognizerQuinta: UITapGestureRecognizer){
        if isQuinta != nil {
            let trueOrFalse = isQuinta
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.quintaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isQuinta = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.quintaView.backgroundColor = UIColor.clear
                    self.isQuinta = "false"
                }, completion:nil)
            }
        } else {
            isQuinta = "false"
            let trueOrFalse = isQuinta
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.quintaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isQuinta = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.quintaView.backgroundColor = UIColor.clear
                    self.isQuinta = "false"
                }, completion:nil)
            }
        }
    }
    @objc func sextaTapped(tapGestureRecognizerSexta: UITapGestureRecognizer){
        if isSexta != nil {
            let trueOrFalse = isSexta
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.sextaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isSexta = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.sextaView.backgroundColor = UIColor.clear
                    self.isSexta = "false"
                }, completion:nil)
            }
        } else {
            isSexta = "false"
            let trueOrFalse = isSexta
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.sextaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isSexta = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.sextaView.backgroundColor = UIColor.clear
                    self.isSexta = "false"
                }, completion:nil)
            }
        }
    }
    @objc func sabadoTapped(tapGestureRecognizerSabado: UITapGestureRecognizer){
        if isSabado != nil {
            let trueOrFalse = isSabado
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.sabadoView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isSabado = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.sabadoView.backgroundColor = UIColor.clear
                    self.isSabado = "false"
                }, completion:nil)
            }
        } else {
            isSabado = "false"
            let trueOrFalse = isSabado
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.sabadoView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isSabado = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.sabadoView.backgroundColor = UIColor.clear
                    self.isSabado = "false"
                }, completion:nil)
            }
        }
    }
    @objc func domingoTapped(tapGestureRecognizerDomingo: UITapGestureRecognizer){
        if isDomingo != nil {
            let trueOrFalse = isDomingo
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.domingoView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isDomingo = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.domingoView.backgroundColor = UIColor.clear
                    self.isDomingo = "false"
                }, completion:nil)
            }
        } else {
            isDomingo = "false"
            let trueOrFalse = isDomingo
            if trueOrFalse == "false"  {
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.domingoView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
                    self.isDomingo = "true"
                    self.isRepeticao = true
                }, completion:nil)
            }
            if trueOrFalse == "true"{
                UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
                    self.domingoView.backgroundColor = UIColor.clear
                    self.isDomingo = "false"
                }, completion:nil)
            }
        }
    }
    
    
    
    @objc func imageHold(longGestureRecognizer: UILongPressGestureRecognizer){
        tappedImage = longGestureRecognizer.view as? UIImageView
        self.becomeFirstResponder()
        
        if (tappedImage?.image) != firstImage{
            if longGestureRecognizer.state == .began{
                UIView.animate(withDuration: 0.5, animations: {
                    self.deleteImageButton.isEnabled = true
                    self.editImageButton.isEnabled = true
                    self.deleteImageButton.alpha = 1.0
                    self.editImageButton.alpha = 1.0
                    self.scrollImage.alpha = 0.1
                    
                    self.deleteImageButton.frame.origin.x += 90
                    self.editImageButton.frame.origin.x -= 90
                })
                
                
            }else if longGestureRecognizer.state == .changed {
                let fingerLocation = longGestureRecognizer.location(in: self.view)
                let deleteButtonViewFrame = self.view.convert(deleteImageButton.frame, from: deleteImageButton.superview)
                let editButtonViewFrame = self.view.convert(editImageButton.frame, from: editImageButton.superview)
                
                if (deleteButtonViewFrame.contains(fingerLocation)){
                    
                    
                    
            
                    for (index, imagens) in imageArray.enumerated() {
                        let imagens = imagens as! UIImage
                        if (tappedImage?.image == imagens){
                            
                            isDelete = true
                            
                            if imageArray.count == 1{
                                firstImage = #imageLiteral(resourceName: "Logo")
                                self.definirview(imageArray: [firstImage])
                            }
                            imageArray.remove(at: index)
                            self.definirview(imageArray: imageArray as! Array<UIImage>)
                        }
                    }
                    
                    
                    
                }
                
                if (editButtonViewFrame.contains(fingerLocation)){
                    
                    UIView.animate(withDuration: 0.5, animations: {
                        self.deleteImageButton.isEnabled = false
                        self.editImageButton.isEnabled = false
                        self.deleteImageButton.alpha = 0.0
                        self.editImageButton.alpha = 0.0
                        self.scrollImage.alpha = 1.0
                        if (self.isDelete == false && self.isEditImage == false){
                            
                            self.deleteImageButton.frame.origin.x -= 90
                            self.editImageButton.frame.origin.x += 90
                        }
                    })
                    
                    
                    isEditImage = true
                    picker.allowsEditing = false
                    picker.sourceType = .photoLibrary
                    picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                    picker.modalPresentationStyle = .popover
                    present(picker, animated: true, completion: nil)
                }
                
            }
            
            if longGestureRecognizer.state == .ended{
                
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.deleteImageButton.isEnabled = false
                    self.editImageButton.isEnabled = false
                    self.deleteImageButton.alpha = 0.0
                    self.editImageButton.alpha = 0.0
                    self.scrollImage.alpha = 1.0
                    if (self.isDelete == false && self.isEditImage == false){
                      
                        self.deleteImageButton.frame.origin.x -= 90
                        self.editImageButton.frame.origin.x += 90
                    }

                    
                })
                isDelete = false
                isEditImage = false
                
            }
        }
        
    }
    
    
    /*
    override func touchesBegan() {
        print ("testeee1")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print ("testeeeeee")
        let touch = touches.first
        let touchLocation = touch?.location(in: self.view)
        print (touch)
        print (touchLocation)
        if deleteImageButton.frame.contains(touchLocation!) {
            print ("teste")
        }
        
    }*/
 
    @objc func scrollViewTapped() {
        print("scrollViewTapped")
    }
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        tappedImage = tapGestureRecognizer.view as? UIImageView
        if imageArray.count<3 {
            tappedImage = tapGestureRecognizer.view as? UIImageView
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            //let newImage = UIImageView()
            if (tappedImage?.image) == firstImage{
                tappedImage?.image = selectedImage
            }
            if isEditImage == true {
                for (index, imagens) in imageArray.enumerated() {
                    let imagens = imagens as! UIImage
                    if (tappedImage?.image == imagens){
                        imageArray[index] = selectedImage
                        self.definirview(imageArray: imageArray as! Array<UIImage>)
                    }
                }
            } else{
                verificaSeTemImagem = true
                imageArray.append (selectedImage)
                definirview(imageArray: imageArray as! Array<UIImage>)
            }
        }
        else {
            print ("ué")
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

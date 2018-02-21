//
//  DetalhesComidinhasViewController.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 28/4/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit

class DetalhesComidinhasViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    
    @IBOutlet var favoriteButton: UIButton!{
        didSet{
            favoriteButton.alpha = 0.0
            favoriteButton.layer.cornerRadius = 5
            favoriteButton.setTitle("\u{2665}", for: .normal)
        }
    }
    
    
    //MARK: Load Views
    var manhaView = UIView()
    var tardeView = UIView()
    var noiteView = UIView()
    var preco = UILabel()
    var sobre = UILabel()
    var descricao = UILabel()
    var doceOuSalgado = UIImageView()
    var veganoImage = UIImageView()
    var nomeDoVendedor = UILabel()
    var scrollImage = UIScrollView()
    var imageArray = [UIImage]()
    
    
    //MARK: Variables
    var isManha: String?
    var isTarde: String?
    var isNoite: String?
    var nomeVendedorComdidinhas: String?
    var nomeProdutoComdidinhas: String?
    var precoLabelComdidinhas: String?
    var veganoComdidinhas: String?
    var salgadoOuDoceComdidinhas: String?
    
    
    
    //MARK: Mudar nome no titulo
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = nomeProdutoComdidinhas
        scrollImage.showsHorizontalScrollIndicator = false
        scrollImage.showsVerticalScrollIndicator = false
        definirview()
        
    }
    
    
        
        
        
        
        
        
    func definirview(){
        
        
        if (isManha=="true" && isTarde=="true" && isNoite=="true"){
            manhaView.frame = CGRect (x: 0, y: 0, width:self.scrollView.frame.width/3, height: 15)
            manhaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            tardeView.frame = CGRect (x: self.scrollView.frame.width/3 , y: 0 , width:self.scrollView.frame.width/3, height: 15)
            tardeView.backgroundColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1)
            noiteView.frame = CGRect (x: 2*(self.scrollView.frame.width/3) , y: 0 , width:self.scrollView.frame.width/3, height: 15)
            noiteView.backgroundColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1)
            
        } else if (isManha=="true" && isTarde=="true" && isNoite=="false"){
            manhaView.frame = CGRect (x: 0, y: 0, width:self.scrollView.frame.width/2, height: 15)
            manhaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            tardeView.frame = CGRect (x: self.scrollView.frame.width/2 , y: 0 , width:self.scrollView.frame.width/2, height: 15)
            tardeView.backgroundColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1)
        } else if (isManha=="true" && isTarde=="false" && isNoite=="true"){
            manhaView.frame = CGRect (x: 0, y: 0, width:self.scrollView.frame.width/2, height: 15)
            manhaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
            noiteView.frame = CGRect (x: (self.scrollView.frame.width/2) , y: 0 , width:self.scrollView.frame.width/2, height: 15)
            noiteView.backgroundColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1)
        } else if (isManha=="false" && isTarde=="true" && isNoite=="true"){
            tardeView.frame = CGRect (x: 0 , y: 0 , width:self.scrollView.frame.width/2, height: 15)
            tardeView.backgroundColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1)
            noiteView.frame = CGRect (x: (self.scrollView.frame.width/2) , y: 0 , width:self.scrollView.frame.width/2, height: 15)
            noiteView.backgroundColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1)
        } else if (isManha=="true" && isTarde=="false" && isNoite=="false"){
            manhaView.frame = CGRect (x: 0, y: 0, width:self.scrollView.frame.width, height: 15)
            manhaView.backgroundColor = #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1)
        } else if (isManha=="false" && isTarde=="true" && isNoite=="false"){
            tardeView.frame = CGRect (x: 0, y: 0, width:self.scrollView.frame.width, height: 15)
            tardeView.backgroundColor = #colorLiteral(red: 0.5060675761, green: 0.5060675761, blue: 0.5060675761, alpha: 1)
        } else if (isManha=="false" && isTarde=="false" && isNoite=="true"){
            noiteView.frame = CGRect (x: 0, y: 0, width:self.scrollView.frame.width, height: 15)
            noiteView.backgroundColor = #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1)
        }
        
        scrollImage.frame = CGRect(x: 0, y: 15, width: self.scrollView.frame.width, height: self.scrollView.frame.height/2.5)
        scrollImage.isPagingEnabled = true
        imageArray = [#imageLiteral(resourceName: "Logo"), #imageLiteral(resourceName: "Logo")]
        
        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.image = imageArray[i]
            imageView.contentMode = .scaleAspectFit
            let Position = self.scrollView.frame.width * CGFloat(i)
            imageView.frame = CGRect (x: Position, y: 0, width: self.scrollImage.frame.width, height: self.scrollImage.frame.height)
            
            
            scrollImage.contentSize.width = scrollImage.frame.width * CGFloat(i + 1)
            scrollImage.addSubview(imageView)
            
            
        }
        
        nomeDoVendedor.frame=CGRect(x: 0, y: self.scrollView.frame.height/2.5+120 , width:self.scrollView.frame.width, height: 20)
        nomeDoVendedor.textAlignment = .center
        nomeDoVendedor.textColor = #colorLiteral(red: 0.3588529825, green: 0.5504949689, blue: 0.6134560704, alpha: 1)
        nomeDoVendedor.font = nomeDoVendedor.font.withSize(15)
        nomeDoVendedor.text = nomeVendedorComdidinhas
        
        
        preco.frame=CGRect(x: 0, y: self.scrollView.frame.height/2.5+15 , width:self.scrollView.frame.width, height: 40)
        preco.textAlignment = .center
        preco.font = UIFont.boldSystemFont(ofSize: 35)
        preco.textColor = #colorLiteral(red: 0.5567517281, green: 0.5416491628, blue: 0.5109621882, alpha: 1)
        preco.font = nomeDoVendedor.font.withSize(35)
        preco.text = precoLabelComdidinhas

        
    
        
        
        if (veganoComdidinhas == "true"){
            doceOuSalgado.frame = CGRect(x: (self.scrollView.frame.width/2)+15 , y: self.scrollView.frame.height/2.5+80 , width:30, height: 30)
            doceOuSalgado.image = #imageLiteral(resourceName: "Salgado")
        
            veganoImage.frame = CGRect(x: (self.scrollView.frame.width/2)-45 , y: self.scrollView.frame.height/2.5+80 , width:30, height: 30)
            veganoImage.image = #imageLiteral(resourceName: "Vegano")
        } else {
            doceOuSalgado.frame = CGRect(x: (self.scrollView.frame.width/2)-15 , y: self.scrollView.frame.height/2.5+80 , width:30, height: 30)
            doceOuSalgado.image = #imageLiteral(resourceName: "Salgado")
        }
        
        
        
        
        
        
        sobre.frame=CGRect(x: 0, y: self.scrollView.frame.height/2.5+165 , width:self.scrollView.frame.width, height: 35)
        sobre.textAlignment = .center
        sobre.textColor = #colorLiteral(red: 0.5567517281, green: 0.5416491628, blue: 0.5109621882, alpha: 1)
        sobre.font = nomeDoVendedor.font.withSize(20)
        sobre.text = "Descrição"

        
        
        descricao.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In dui leo, pulvinar sed bibendum sit amet, molestie ut mauris. Suspendisse non diam lorem. Duis nulla dui, viverra euismod lacinia sed, interdum fermentum tellus. Quisque tincidunt ligula sit amet convallis vehicula. Proin in eleifend est, sed faucibus urna. Proin sodales porttitor metus sit amet maximus. Aliquam id pellentesque nibh. Maecenas gravida dignissim lectus eu condimentum. Pellentesque vel nisl orci. Morbi porttitor mi lacus, sit amet condimentum ligula dignissim a. Quisque ante tortor, eleifend in auctor non, mollis at massa. Aliquam eu justo sed sem volutpat tempor sit amet eget nunc. Sed tempor diam at lorem lobortis scelerisque. Sed in ullamcorper ex. Aenean consequat lectus risus, in euismod est vestibulum a. Fusce fringilla ornare ligula, a facilisis purus porttitor eget. Integer sit amet mattis nisi. Ut id velit vel eros tincidunt luctus. Fusce vulputate, augue quis consectetur egestas, dolor quam tincidunt enim, vitae pretium erat magna eget neque. Praesent fermentum non purus ut eleifend. Ut condimentum ligula et est facilisis, a sodales lectus finibus."

            
        descricao.frame=CGRect(x: 5, y: self.scrollView.frame.height/2.5+195 , width:self.scrollView.frame.width-5, height:0)
        descricao.textAlignment = .left
        descricao.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        descricao.font = nomeDoVendedor.font.withSize(15)
        descricao.numberOfLines = 0
        descricao.lineBreakMode = NSLineBreakMode.byWordWrapping
        descricao .sizeToFit()
        
        
    
        self.view.layoutSubviews()
        
        scrollView.contentSize.height = descricao.frame.height + sobre.frame.height + doceOuSalgado.frame.height + nomeDoVendedor.frame.height + scrollImage.frame.height + preco.frame.height + favoriteButton.frame.height + 60
        
        
        scrollView.addSubview(manhaView)
        scrollView.addSubview(tardeView)
        scrollView.addSubview(noiteView)
        scrollView.addSubview(preco)
        scrollView.addSubview(descricao)
        scrollView.addSubview(sobre)
        scrollView.addSubview(veganoImage)
        scrollView.addSubview(doceOuSalgado)
        scrollView.addSubview(nomeDoVendedor)
        scrollView.addSubview(scrollImage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if ((scrollView.contentOffset.y + scrollView.bounds.height < scrollView.contentSize.height) == false){
            UIView.animate(withDuration: 0.5, animations: {
                self.favoriteButton.alpha = 1.0
            })
        }
        if ((scrollView.contentOffset.y + scrollView.bounds.height < scrollView.contentSize.height) == true){
            UIView.animate(withDuration: 0.5, animations: {
                self.favoriteButton.alpha = 0.0
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  VendasViewController.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 11/4/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit
import Firebase

class VendasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var vendasView: UIView!
    var deleteImageLabel = UILabel()
    var deleteImageButton = UIButton()
    var editImageButton = UIButton()
    //MARK: Variaveis
    var pieChart: PieChart!
    var vendas = [Vendas]()
    @IBOutlet var vendasTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.vendasTableView.indexPathForSelectedRow{
            self.vendasTableView.deselectRow(at: index, animated: true)
        }
    }
    
    @IBAction func unwindVendas(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? DetalhesVendasViewController, let venda = sourceViewController.venda
        {
            if let selectedIndexPath = vendasTableView.indexPathForSelectedRow {
                vendas[selectedIndexPath.row] = venda
                //pieChart = PieChart(isManha: venda.isManha, isTarde: venda.isTarde, isNoite: venda.isNoite)
                vendasTableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new venda.
                let newIndexPath = IndexPath(row: vendas.count, section: 0)
                vendas.append(venda)
                vendasTableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = self.vendasTableView.indexPathForSelectedRow{
            self.vendasTableView.deselectRow(at: index, animated: true)
        }
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        self.view.addGestureRecognizer(longPressRecognizer)
        loadInfo()
        configureTableView()
        
        
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        let touchPoint = longPressGestureRecognizer.location(in: vendasTableView)
        if let indexPath = vendasTableView.indexPathForRow(at: touchPoint){
            if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
                let aSize = CGSize(width: 50.0, height: 50.0)
                
                deleteImageButton.frame = CGRect(origin: touchPoint, size: aSize)
                editImageButton.frame = CGRect(origin: touchPoint, size: aSize)
                deleteImageButton.frame.origin.y = deleteImageButton.frame.origin.y + 30
                editImageButton.frame.origin.y = editImageButton.frame.origin.y + 30
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
                
                editImageButton.layer.borderWidth = 2
                editImageButton.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
                editImageButton.layer.cornerRadius = self.deleteImageButton.frame.size.width/2
                editImageButton.isEnabled = false
                editImageButton.alpha = 0.0
                editImageButton.setImage(#imageLiteral(resourceName: "Edit"), for: [])
                vendasView.addSubview(deleteImageButton)
                vendasView.addSubview(editImageButton)
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.deleteImageButton.isEnabled = true
                    self.editImageButton.isEnabled = true
                    self.deleteImageButton.alpha = 1.0
                    self.editImageButton.alpha = 1.0
                    self.vendasTableView.alpha = 0.1
                    self.deleteImageButton.frame.origin.x += 70
                    self.editImageButton.frame.origin.x -= 70
                })
                
                
            } else if longPressGestureRecognizer.state == UIGestureRecognizerState.changed {
                    let fingerLocation = longPressGestureRecognizer.location(in: self.view)
                    let deleteButtonViewFrame = self.view.convert(deleteImageButton.frame, from: deleteImageButton.superview)
                    let editButtonViewFrame = self.view.convert(editImageButton.frame, from: editImageButton.superview)
                
                    if (deleteButtonViewFrame.contains(fingerLocation)){
                        self.vendas.remove(at: indexPath.row)
                        self.vendasTableView.deleteRows(at: [indexPath], with: .automatic)
                        UIView.animate(withDuration: 0.5, animations: {
                            self.deleteImageButton.isEnabled = false
                            self.editImageButton.isEnabled = false
                            self.deleteImageButton.alpha = 0.0
                            self.editImageButton.alpha = 0.0
                            self.vendasTableView.alpha = 1.0
                            self.deleteImageButton.frame.origin.x -= 70
                            self.editImageButton.frame.origin.x += 70
                        })
                    }
                    if (editButtonViewFrame.contains(fingerLocation)){
                    }
            }
        }
        if longPressGestureRecognizer.state == UIGestureRecognizerState.ended{
                
                
            UIView.animate(withDuration: 0.5, animations: {
                self.deleteImageButton.isEnabled = false
                self.editImageButton.isEnabled = false
                self.deleteImageButton.alpha = 0.0
                self.editImageButton.alpha = 0.0
                self.vendasTableView.alpha = 1.0
                self.deleteImageButton.frame.origin.x -= 70
                self.editImageButton.frame.origin.x += 70
                
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if tableView == self.vendasTableView{
            let active = UITableViewRowAction(style: .normal, title: "Ativar") { action, index in
                print("active button tapped")
            }
            let delete = UITableViewRowAction(style: .normal, title: "Deletar") { action, index in
                self.vendas.remove(at: indexPath.row)
                self.vendasTableView.deleteRows(at: [indexPath], with: .automatic)
            }
            delete.backgroundColor = #colorLiteral(red: 0.3588529825, green: 0.5504949689, blue: 0.6134560704, alpha: 1)
            active.backgroundColor = #colorLiteral(red: 0.615627408, green: 0.6043154597, blue: 0.5780405402, alpha: 1)
            return [active, delete]
        } else {
            return nil
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vendas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "VendasTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VendasTableViewCell else {
            fatalError("The dequeued cell is not an instance of VendasTableViewCell.")
        }
        
        let venda = vendas[indexPath.row]
        pieChart = PieChart(isManha: venda.isManha, isTarde: venda.isTarde, isNoite: venda.isNoite)
        pieChart?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        pieChart?.frame = CGRect(x: 0, y: 0, width: cell.manha.frame.width, height: cell.manha.frame.height)
        cell.manha.addSubview(pieChart!)
        cell.unidadesVendidas.text = venda.unidadesVendidas
        cell.nomeProduto.text = venda.nomeProdutoVendas
        cell.imagemProduto.image = venda.imagemProdutoVendas
        cell.precoLabel.text = venda.precoLabelVendas
        
        if (venda.veganoImagemVendas == "true"){
            cell.veganoImagem.image = UIImage(named: "VeganoVendas")
        } else {
            cell.veganoImagem.image = nil
        }
        
        if (venda.salgadoOuDoceImagemVendas == "salgado"){
            cell.salgadoOuDoceImagem.image = UIImage(named: "SalgadoVendas")
        }
        
        return cell
        
        
    }
    
    //MARK: Configure Table View
    func configureTableView() {
        vendasTableView.delegate = self
        vendasTableView.dataSource = self
        vendasTableView.tableFooterView = UIView()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ident = segue.identifier {
            switch ident {
            case "DetalhesVendasViewController":
                /*let backButton = UIBarButtonItem()
                backButton.title = "Voltar"
                navigationItem.backBarButtonItem = backButton
                */
                guard let detalhesVendasViewController = segue.destination as? DetalhesVendasViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let indexPath = vendasTableView.indexPathForSelectedRow else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let venda: Vendas
                venda = vendas[indexPath.row]
                detalhesVendasViewController.isRepeticao = venda.isRepeticao
                detalhesVendasViewController.isSegunda = venda.isSegunda
                detalhesVendasViewController.isTerca = venda.isTerca
                detalhesVendasViewController.isQuarta = venda.isQuarta
                detalhesVendasViewController.isQuinta = venda.isQuinta
                detalhesVendasViewController.isSexta = venda.isSexta
                detalhesVendasViewController.isSabado = venda.isSabado
                detalhesVendasViewController.isDomingo = venda.isDomingo
                detalhesVendasViewController.isManha = venda.isManha
                detalhesVendasViewController.isTarde = venda.isTarde
                detalhesVendasViewController.isNoite = venda.isNoite
                detalhesVendasViewController.nomeProdutoVendas = venda.nomeProdutoVendas
                detalhesVendasViewController.precoLabelVendas = venda.precoLabelVendas
                detalhesVendasViewController.veganoVendas = venda.veganoImagemVendas
                detalhesVendasViewController.salgadoOuDoceVendas = venda.salgadoOuDoceImagemVendas
            
            case "Add Item":
                /*let backButton = UIBarButtonItem()
                backButton.title = "Voltar"
                navigationItem.backBarButtonItem = backButton
                */
                guard segue.destination is DetalhesVendasViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
            default: break
            }
        }
        
    }
    
    
    
    
    
    //MARK: Função de Teste
    private func loadInfo(){
        
        let vendas1 = Vendas(isSegunda: "false",
                             isTerca: "false",
                             isQuarta: "false",
                             isQuinta: "false",
                             isSexta: "false",
                             isSabado: "true",
                             isDomingo: "true",
                             isRepeticao: true,
                            isManha: "false" ,  isTarde: "false", isNoite: "false",
                             unidadesVendidas: "200 Unidades Vendidas",
                             nomeProdutoVendas: "Brigadeiro",
                             imagemProdutoVendas: UIImage(named:"Logo")!,
                             precoLabelVendas: "R$5,00",
                             veganoImagemVendas: "true",
                             salgadoOuDoceImagemVendas: "salgado")
        
        
        let vendas2 = Vendas(isSegunda: "false",
                             isTerca: "false",
                             isQuarta: "false",
                             isQuinta: "false",
                             isSexta: "false",
                             isSabado: "false",
                             isDomingo: "false",
                             isRepeticao: false,
                            isManha: "true" ,  isTarde: "true", isNoite: "false",
                             unidadesVendidas: "10 Unidades Vendidas",
                             nomeProdutoVendas: "Chocolate",
                             imagemProdutoVendas: UIImage(named:"Logo")!,
                             precoLabelVendas: "R$4,00",
                             veganoImagemVendas: "true",
                             salgadoOuDoceImagemVendas: "salgado")
        
        
        vendas += [vendas1, vendas2]
        
        
    }
    
    
}

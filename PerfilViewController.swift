//
//  PerfilViewController.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 19/2/18.
//  Copyright © 2018 Nicolas Melo. All rights reserved.
//

import UIKit
import RealmSwift

class PerfilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //MARK: Variaveis
    @IBOutlet var perfilMenu: UITableView!
    @IBOutlet var saveButton: UIButton!
    
    
    var cellProperties: Results<Profile>!
    
    var visibleRowsPerSection = [[Int]]()
    var isTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadToRealm()
        configureTableView()
        configureSaveButton()
        loadCellDescriptors()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func configureSaveButton (){
        self.isTapped = false
        self.saveButton.alpha=0.0
        self.saveButton.frame = CGRect(x: 5, y: self.view.frame.height-50 , width: self.view.frame.width-10 , height: 45)
    }
    
    
    //MARK: Configure TableView
    func configureTableView(){
        saveButton.layer.cornerRadius = 5
        
        
        
        
        perfilMenu.delegate = self
        perfilMenu.dataSource = self
        perfilMenu.tableFooterView = UIView()
        self.perfilMenu.separatorStyle = .none
        
        //perfilMenu.register(UINib(nibName: "FotoCell", bundle: nil), forCellReuseIdentifier: "idFotoCell")
        perfilMenu.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "idCellMenu")
        perfilMenu.register(UINib(nibName: "NormalCell", bundle: nil), forCellReuseIdentifier: "idCellNormal")
        perfilMenu.register(UINib(nibName: "NadaCell", bundle: nil), forCellReuseIdentifier: "idCellNada")
    }
    
    
    //MARK: Custom Atributes
    func loadCellDescriptors() {
        let realm = try! Realm()
        cellProperties = realm.objects(Profile.self)
        getIndicesOfVisibleRows()
        perfilMenu.reloadData()
    }
    
    
    func getIndicesOfVisibleRows() {
        visibleRowsPerSection.removeAll()
        for (index, currentSectionCells) in cellProperties.enumerated()  {
            var visibleRows = [Int]()
            
            if currentSectionCells["isVisible"] as! Bool == true {
                visibleRows.append(index)
            }
            /*
             for row in 0...((currentSectionCells as AnyObject).count - 1) {
             
             if currentSectionCells["isVisible"] as! Bool == true {
             visibleRows.append(row)
             }
             }*/
            visibleRowsPerSection.append(visibleRows)
        }
    }
    
    func getCellPropertiesForIndexPath(_ indexPath: IndexPath) -> Profile{
        let indexOfVisibleRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let cellProperty = cellProperties[indexPath.section]
        return cellProperty
    }
    
    
    //MARK:TableView Delegate e DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if cellProperties != nil {
            return cellProperties.count
        }
        else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let count = visibleRowsPerSection[section].count
        print("______________")
        print(count)
        return count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCellProperties = getCellPropertiesForIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: currentCellProperties["cellIdentifier"] as! String, for: indexPath) as! CustomCell
        
        if currentCellProperties["cellIdentifier"] as! String == "idCellMenu" {
            switch currentCellProperties["primaryTitle"] as! String {
            case "Config":
                cell.fotoMenu.image = UIImage (named: "Configuracoes")
                
            case "Favoritos":
                cell.fotoMenu.image = UIImage (named: "Favoritos")
                
            case "Vendidos":
                cell.fotoMenu.image = UIImage (named: "Vendas")
                
            default:
                cell.fotoMenu.image = UIImage (named: "Configuracoes")
            }
        }
            
        else if currentCellProperties["cellIdentifier"] as! String == "idCellNormal" {
            
            //Inicializando Estados
            cell.textNormalLabel.isHidden = false
            cell.textField.isHidden = false
            cell.fotoUser.isHidden = false
            cell.textField.isSecureTextEntry = false
            
            
            if (currentCellProperties["secondaryTitle"] as? String == "Foto") {
                cell.textNormalLabel.isHidden = true
                cell.textField.isHidden = true
                cell.fotoUser.layer.masksToBounds = false
                cell.fotoUser.layer.cornerRadius = cell.fotoUser.frame.height/2
                cell.fotoUser.clipsToBounds = true
                cell.fotoUser.image = UIImage (named: "Logo")
                print("teste1")
            }
            else if (currentCellProperties["secondaryTitle"] as? String == "Senha") {
                
                cell.fotoUser.isHidden = true
                cell.textField.isSecureTextEntry = true
                cell.textNormalLabel.text = currentCellProperties["primaryTitle"] as? String
                print("teste2")
                
            }
            else {
                cell.fotoUser.isHidden = true
                cell.textNormalLabel.text = currentCellProperties["primaryTitle"] as? String
                print("teste3")
            }
            
            
            
            cell.textNormalLabel?.text = currentCellProperties["secondaryTitle"] as? String
            cell.textField.text = "teste"
        }
            
            
        else if currentCellProperties["cellIdentifier"] as! String == "idCellNada" {
            
            if (currentCellProperties["secondaryTitle"] as? String == "NTemFavoritos") {
                cell.nadaLabel.text = "Você ainda não tem nenhum favorito, poxa ):"
            }
            else if (currentCellProperties["secondaryTitle"] as? String == "NTemVendidos") {
                cell.nadaLabel.text = "It's not about the money, venda algo :D"
            }
            
        }
        
        
        
        
        
        
        
        
        
        /*else if currentCellProperties["cellIdentifier"] as! String == "idCellFoto" {
         let fotoName =  currentCellProperties["secondaryTitle"] as? String
         cell.fotoUser.image = UIImage (named: fotoName!)
         }*/
        
        //cell.delegate = self
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentCellProperty = getCellPropertiesForIndexPath(indexPath)
        
        switch currentCellProperty["cellIdentifier"] as! String {
            
        case "idCellNormal":
            return 90.0
            
        case "idCellNada":
            return 90.0
            
            
        default:
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if (indexPath.row > 0 && indexPath.row < 5) {
            return nil
        } else {
            return indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexOfTappedRow = visibleRowsPerSection[indexPath.section][indexPath.row]
        let currentCellProperties = getCellPropertiesForIndexPath(indexPath)
        //show saveButton
        if (currentCellProperties["cellIdentifier"] as! String == "idCellMenu"){
            if(currentCellProperties["primaryTitle"] as! String == "Config" && isTapped == false){
                self.isTapped = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.saveButton.frame.origin.y -= 50
                    self.saveButton.alpha = 1.0
                })
            }
                
            else if (currentCellProperties["primaryTitle"] as! String == "Config" && isTapped == true){
                self.isTapped = false
                UIView.animate(withDuration: 0.5, animations: {
                    self.saveButton.frame.origin.y += 50
                    self.saveButton.alpha=0.0
                })
            }
        }
        
        //resto
        if cellProperties[indexOfTappedRow]["isExpandable"]! as! Bool == true {
            var shouldExpandAndShowSubRows = false
            print("teste1")
            if cellProperties[indexOfTappedRow]["isExpanded"] as! Bool == false {
                // In this case the cell should expand.
                shouldExpandAndShowSubRows = true
                print("teste2")
            }
            let realm = try! Realm()
            
            // Persist your data easily
            try! realm.write {
                cellProperties[indexOfTappedRow].isExpanded = shouldExpandAndShowSubRows
            }
            
            
            
            let predicate = NSPredicate(format: "relatesTo = %@", cellProperties[indexOfTappedRow]["primaryTitle"] as! String)
            let cellsToShow = realm.objects(Profile.self).filter(predicate)
            for cells in cellsToShow{
                //((cellProperties[indexPath.section]  as! NSMutableArray)[i] as AnyObject).setValue(shouldExpandAndShowSubRows, forKey: "isVisible")
                try! realm.write {
                    cells.isVisible = shouldExpandAndShowSubRows
                }
            }
        }
        getIndicesOfVisibleRows()
        self.perfilMenu.reloadData()
        //self.perfilMenu.reloadSections(IndexSet(integer: indexPath.section), with: UITableViewRowAnimation.fade)
    }
    
    
    
    func textfieldTextWasChanged(_ newText: String, parentCell: CustomCell) {
        let parentCellIndexPath = perfilMenu.indexPath(for: parentCell)
        
        let currentFullname = ((cellProperties[0] as! NSMutableArray)[0] as AnyObject)["primaryTitle"] as! String
        let fullnameParts = currentFullname.components(separatedBy: " ")
        
        var newFullname = ""
        
        if parentCellIndexPath?.row == 1 {
            if fullnameParts.count == 2 {
                newFullname = "\(newText) \(fullnameParts[1])"
            }
            else {
                newFullname = newText
            }
        }
        else {
            newFullname = "\(fullnameParts[0]) \(newText)"
        }
        
        ((cellProperties[0] as! NSMutableArray)[0] as AnyObject).setValue(newFullname, forKey: "primaryTitle")
        perfilMenu.reloadData()
    }
    
    
    func loadToRealm(){
        let config = Profile()
        config.additionalRows = 5
        config.cellIdentifier = "idCellMenu"
        config.primaryTitle = "Config"
        config.isExpanded = false
        config.isExpandable = true
        config.isVisible = true
        config.id = 1
        
        let fotoConfig = Profile()
        fotoConfig.isExpanded = false
        fotoConfig.isExpandable = false
        fotoConfig.isVisible = false
        fotoConfig.secondaryTitle = "Foto"
        fotoConfig.cellIdentifier = "idCellNormal"
        fotoConfig.additionalRows = 0
        fotoConfig.relatesTo = "Config"
        fotoConfig.id = 2
        
        let nomeConfig = Profile()
        nomeConfig.isExpanded = false
        nomeConfig.isExpandable = false
        nomeConfig.isVisible = false
        nomeConfig.secondaryTitle = "Nome"
        nomeConfig.cellIdentifier = "idCellNormal"
        nomeConfig.additionalRows = 0
        nomeConfig.relatesTo = "Config"
        nomeConfig.id = 3
        
        let telConfig = Profile()
        telConfig.isExpanded = false
        telConfig.isExpandable = false
        telConfig.isVisible = false
        telConfig.secondaryTitle = "Telefone"
        telConfig.cellIdentifier = "idCellNormal"
        telConfig.additionalRows = 0
        telConfig.relatesTo = "Config"
        telConfig.id = 4
        
        let emailConfig = Profile()
        emailConfig.isExpanded = false
        emailConfig.isExpandable = false
        emailConfig.isVisible = false
        emailConfig.secondaryTitle = "E-Mail"
        emailConfig.cellIdentifier = "idCellNormal"
        emailConfig.additionalRows = 0
        emailConfig.relatesTo = "Config"
        emailConfig.id = 5
        
        let senhaConfig = Profile()
        senhaConfig.isExpanded = false
        senhaConfig.isExpandable = false
        senhaConfig.isVisible = false
        senhaConfig.secondaryTitle = "Senha"
        senhaConfig.cellIdentifier = "idCellNormal"
        senhaConfig.additionalRows = 0
        senhaConfig.relatesTo = "Config"
        senhaConfig.id = 6
        
        let favorite = Profile()
        favorite.additionalRows = 1
        favorite.cellIdentifier = "idCellMenu"
        favorite.primaryTitle = "Favoritos"
        favorite.isExpanded = false
        favorite.isExpandable = true
        favorite.isVisible = true
        favorite.id = 7
        
        let noFavorites = Profile()
        noFavorites.isExpanded = false
        noFavorites.isExpandable = false
        noFavorites.isVisible = false
        noFavorites.secondaryTitle = "NTemFavoritos"
        noFavorites.cellIdentifier = "idCellNada"
        noFavorites.additionalRows = 0
        noFavorites.relatesTo = "Favoritos"
        noFavorites.id = 8
        
        let sold = Profile()
        sold.additionalRows = 1
        sold.cellIdentifier = "idCellMenu"
        sold.primaryTitle = "Vendidos"
        sold.isExpanded = false
        sold.isExpandable = true
        sold.isVisible = true
        sold.id = 9
        
        let noSold = Profile()
        noSold.isExpanded = false
        noSold.isExpandable = false
        noSold.isVisible = false
        noSold.secondaryTitle = "NTemVendidos"
        noSold.cellIdentifier = "idCellNada"
        noSold.additionalRows = 0
        noSold.relatesTo = "Vendidos"
        noSold.id = 10
        
        let realm = try! Realm()
        
        // Persist your data easily
        try! realm.write {
            var itens = [Profile]()
            itens += [config, fotoConfig, nomeConfig, telConfig, emailConfig, senhaConfig, favorite, noFavorites, sold, noSold]
            for i in itens{
                realm.add(i, update: true)
            }
        }
        
        print()
    }
    
    
    
    
    
}

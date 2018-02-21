//
//  ComidinhasViewController.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 11/4/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//
import os.log
import UIKit
import Firebase

class ComidinhasViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //MARK: Variaveis Comidinhas
    
    var comidinhas=[Comidinhas]()
    
    @IBOutlet var comidinhasTableView: UITableView!
    var filteredComidinhas = [Comidinhas]()
    

    
    
    
    //MARK: Variaveis Filter
    var filters=[Filter]()
    
    
    @IBOutlet var heightFilterConstraint: NSLayoutConstraint!
    @IBOutlet var filterTableView: UITableView!
    @IBOutlet var filterButton: UIBarButtonItem!
    var isVeganoSelected = false
    var isDoceSelected = false
    var isSalgadoSelected = false
    var isManhaSelected = false
    var isTardeSelected = false
    var isNoiteSelected = false
    var searchController: UISearchController!
    var cellProperties: NSMutableArray!
    
    //MARK: Variaveis para passar
    var isManha: Bool = false
    var isTarde: Bool = false
    var isNoite: Bool = false
    var nomeVendedorComdidinhas: String = ""
    var nomeProdutoComdidinhas: String = ""
    var precoLabelComdidinhas: String = ""
    var veganoComdidinhas: Bool = false
    var salgadoOuDoceComdidinhas: String = ""
    
    
    //MARK: Funções ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()

        loadInfosFilter()
        configureTableViewFilter()
        
        
        loadInfosComidinhas()
        configureTableViewComidinhas()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectionIndexPath = self.filterTableView.indexPathForSelectedRow {
            self.filterTableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredComidinhas = comidinhas.filter { comidinha in
            return comidinha.nomeProdutoComdidinhas.lowercased().contains(searchText.lowercased())
        }
        
        comidinhasTableView.reloadData()
    }

    
    
    //MARK: Funções TableView
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if tableView == self.comidinhasTableView{
            let favorite = UITableViewRowAction(style: .normal, title: "\u{2665}") { action, index in
                if let path = Bundle.main.path(forResource: "CellProperties", ofType: "plist") {
                    self.cellProperties = NSMutableArray(contentsOfFile: path)
                    for cells in self.cellProperties{
                        print((cells as AnyObject))
                    }
                }
            }
            favorite.backgroundColor = #colorLiteral(red: 0.615627408, green: 0.6043154597, blue: 0.5780405402, alpha: 1)
            return [favorite]
        } else {
            return nil
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        var count:Int?
        
        if tableView == self.comidinhasTableView{
            if searchController.isActive && searchController.searchBar.text != "" {
                return filteredComidinhas.count
            }
            return comidinhas.count
        }
        
        
        if tableView == self.filterTableView{
            count = filters.count
        }
        
        return count!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if tableView == self.comidinhasTableView {
            let cellIdentifier = "ComidinhasTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ComidinhasTableViewCell
        
            let comidinha: Comidinhas
        
            
            if searchController.isActive && searchController.searchBar.text != "" {
                comidinha = filteredComidinhas[indexPath.row]
            } else {
                comidinha = comidinhas[indexPath.row]
            }
            
            
            
            
            let pieChart = PieChart(isManha: comidinha.isManha, isTarde: comidinha.isTarde, isNoite: comidinha.isNoite)
            pieChart?.backgroundColor=#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            pieChart?.frame = CGRect(x: 0, y: 0, width: (cell?.manha.frame.width)!, height: cell!.manha.frame.height)
        
            cell?.manha.addSubview(pieChart!)
            cell?.nomeVendedor.text = comidinha.nomeVendedorComdidinhas
            cell?.nomeProduto.text = comidinha.nomeProdutoComdidinhas
            cell?.imagemProduto.image = comidinha.imagemProdutoComidinhas
            cell?.precoLabel.text = comidinha.precoLabelComdidinhas
        
            if (comidinha.veganoComdidinhas == "true"){
                cell!.veganoImagem.image = UIImage(named: "Vegano")!
            } else{
                cell!.veganoImagem.image = nil
            }
        
            if (comidinha.salgadoOuDoceComdidinhas == "salgado"){
                cell!.salgadoOuDoceImagem.image = UIImage(named: "Salgado")!
            }
            
            return cell!
            
        } else {
            let cellIdentifier = "FilterTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FilterTableViewCell
            
            let filter = filters[indexPath.row]
            
            cell?.filtro.text = filter.filterType
            
            return cell!
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView == self.comidinhasTableView{
            
        }
        
        if tableView == self.filterTableView{
            
    
            
            if (indexPath.row == 0){
                comidinhas.removeAll()
                loadInfosComidinhas()
                isVeganoSelected = false
                if isManhaSelected == true{
                    comidinhas = comidinhas.filter{$0.isManha == "true"}
                } else if isTardeSelected == true {
                    comidinhas = comidinhas.filter{$0.isTarde == "true"}
                } else if isNoiteSelected == true {
                    comidinhas = comidinhas.filter{$0.isNoite == "true"}
                }
                
                self.comidinhasTableView.reloadData()
            }
            if (indexPath.row == 3) {
                comidinhas.removeAll()
                loadInfosComidinhas()
                isManhaSelected = false
                if isVeganoSelected == true{
                    comidinhas = comidinhas.filter{$0.veganoComdidinhas == "true"}
                }
                if isTardeSelected == true {
                    comidinhas = comidinhas.filter{$0.isTarde == "true"}
                }
                if isNoiteSelected == true {
                    comidinhas = comidinhas.filter{$0.isNoite == "true"}
                }
                
                self.comidinhasTableView.reloadData()
                
            }
            if (indexPath.row == 4) {
                comidinhas.removeAll()
                loadInfosComidinhas()
                isTardeSelected = false
                if isManhaSelected == true{
                    comidinhas = comidinhas.filter{$0.isManha == "true"}
                }
                if isVeganoSelected == true {
                    comidinhas = comidinhas.filter{$0.veganoComdidinhas == "true"}
                }
                if isNoiteSelected == true {
                    comidinhas = comidinhas.filter{$0.isNoite == "true"}
                }
                
                self.comidinhasTableView.reloadData()
                
            }
            
            if (indexPath.row == 5) {
                comidinhas.removeAll()
                loadInfosComidinhas()
                isNoiteSelected = false
                if isManhaSelected == true{
                    comidinhas = comidinhas.filter{$0.isManha == "true"}
                }
                if isTardeSelected == true {
                    comidinhas = comidinhas.filter{$0.isTarde == "true"}
                }
                if isVeganoSelected == true {
                    comidinhas = comidinhas.filter{$0.veganoComdidinhas == "true"}
                }
                
                self.comidinhasTableView.reloadData()
            }
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.comidinhasTableView {
            
            
            
            
            
        }
        
        if tableView == self.filterTableView{
            
            
            
            if (indexPath.row == 0){
                filterVegano()
            }
            
            
            
            else if (indexPath.row == 1){
                filterDoces()
            }
            else if (indexPath.row == 2){
                filterVegano()
            }
            
            
            else if (indexPath.row == 3){
                filterManha()
            }
            
            else if (indexPath.row == 4){
                filterTarde()
            }
            else if (indexPath.row == 5){
                filterNoite()
            }
        }
    }
    
    
    //MARK: Configure Table View
    func configureTableViewComidinhas() {
        comidinhasTableView.dataSource = self
        comidinhasTableView.tableFooterView = UIView()
    }
    
    
    func configureTableViewFilter() {
        filterTableView.isHidden = true
        self.heightFilterConstraint.constant = 0
        
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.tableFooterView = UIView()
    }
    
    //MARK: Configure SearchBar
    func configureSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = true
        //definesPresentationContext = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width-90, height: 40.0)
        /*let barContainer = UIView(frame: searchController.searchBar.frame)
        barContainer.backgroundColor = UIColor.clear
        barContainer.addSubview(searchController.searchBar)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: barContainer)
        */
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.tintColor = #colorLiteral(red: 0.3588529825, green: 0.5504949689, blue: 0.6134560704, alpha: 1)
        // Include the search bar within the navigation bar.
        self.navigationItem.titleView = self.searchController.searchBar
        self.definesPresentationContext = true
        let cancelButtonAttributes: NSDictionary = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? AnyObject as? [NSAttributedStringKey : Any], for: UIControlState.normal)
    }
    
    //MARK: Mudar back button text
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let ident = segue.identifier {
            switch ident {
            case "DetalhesComidinhasViewController":
                let backButton = UIBarButtonItem()
                backButton.title = "Voltar"
                navigationItem.backBarButtonItem = backButton
                
                guard let detalhesComidinhasViewController = segue.destination as? DetalhesComidinhasViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
                
                guard let indexPath = comidinhasTableView.indexPathForSelectedRow else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                let comidinha: Comidinhas
                if searchController.isActive && searchController.searchBar.text != "" {
                    comidinha = filteredComidinhas[indexPath.row]
                } else {
                    comidinha = comidinhas[indexPath.row]
                }
                
                detalhesComidinhasViewController.isManha = comidinha.isManha
                detalhesComidinhasViewController.isTarde = comidinha.isTarde
                detalhesComidinhasViewController.isNoite = comidinha.isNoite
                detalhesComidinhasViewController.nomeVendedorComdidinhas = comidinha.nomeVendedorComdidinhas
                detalhesComidinhasViewController.nomeProdutoComdidinhas = comidinha.nomeProdutoComdidinhas
                detalhesComidinhasViewController.precoLabelComdidinhas = comidinha.precoLabelComdidinhas
                detalhesComidinhasViewController.veganoComdidinhas = comidinha.veganoComdidinhas
                detalhesComidinhasViewController.salgadoOuDoceComdidinhas = comidinha.salgadoOuDoceComdidinhas

            default: break
            }
        }
        
    }

    
    
    
    //MARK: Função de Teste
    private func loadInfosComidinhas(){
        
        
        let comidinhas1 = Comidinhas(isManha: "true", isTarde: "true", isNoite: "false",
                                     nomeVendedorComdidinhas: "Nicolas Leal",
                                     nomeProdutoComdidinhas: "Strogonoff",
                                     imagemProdutoComidinhas: UIImage(named: "Logo")!,
                                     precoLabelComdidinhas: "R$5,00",
                                     veganoComdidinhas: "false",
                                     salgadoOuDoceComdidinhas: "salgado")
        let comidinhas2 = Comidinhas(isManha: "false", isTarde: "true", isNoite: "true",
                                     nomeVendedorComdidinhas: "Viviane Gennari",
                                     nomeProdutoComdidinhas: "Cones",
                                     imagemProdutoComidinhas: UIImage(named: "Logo")!,
                                     precoLabelComdidinhas: "R$4,00",
                                     veganoComdidinhas: "true",
                                     salgadoOuDoceComdidinhas: "salgado")
        let comidinhas3 = Comidinhas(isManha: "true", isTarde: "false", isNoite: "true",
                                     nomeVendedorComdidinhas: "Juan Nogueira",
                                     nomeProdutoComdidinhas: "Trakinas",
                                     imagemProdutoComidinhas: UIImage(named: "Logo")!,
                                     precoLabelComdidinhas: "R$3,00",
                                     veganoComdidinhas: "false",
                                     salgadoOuDoceComdidinhas: "salgado")
        let comidinhas4 = Comidinhas(isManha: "true", isTarde: "true", isNoite: "true",
                                     nomeVendedorComdidinhas: "Hortencia",
                                     nomeProdutoComdidinhas: "Batata Frita",
                                     imagemProdutoComidinhas: UIImage(named: "Logo")!,
                                     precoLabelComdidinhas: "R$2,00",
                                     veganoComdidinhas: "false",
                                     salgadoOuDoceComdidinhas: "salgado")
        let comidinhas5 = Comidinhas(isManha: "true", isTarde: "false", isNoite: "true",
                                     nomeVendedorComdidinhas: "Vinicius Chaim",
                                     nomeProdutoComdidinhas: "Café",
                                     imagemProdutoComidinhas: UIImage(named: "Logo")!,
                                     precoLabelComdidinhas: "R$4,50",
                                     veganoComdidinhas: "true",
                                     salgadoOuDoceComdidinhas: "salgado")
        
        
        comidinhas+=[comidinhas1, comidinhas2, comidinhas3, comidinhas4, comidinhas5]
    }
    
    
    
    private func loadInfosFilter(){
        
        
        
        let filter1 = Filter(filterType:"Vegano")
        let filter2 = Filter(filterType:"Doce")
        let filter3 = Filter(filterType:"Salgado")
        
        
        let filter4 = Filter(filterType:"Manhã")
        let filter5 = Filter(filterType:"Tarde")
        let filter6 = Filter(filterType:"Noite")
        
        
        filters+=[filter1, filter2, filter3, filter4, filter5, filter6]
    }
    
    
    func filterDoces(){
        
    }
    
    
    func filterVegano(){
        
        comidinhas = comidinhas.filter{$0.veganoComdidinhas == "true"}
        isVeganoSelected = true
        self.comidinhasTableView.reloadData()
    }
    
    func filterManha(){
        
        comidinhas = comidinhas.filter{$0.isManha == "true"}
        isManhaSelected = true
        self.comidinhasTableView.reloadData()
    }
    
    func filterTarde(){
        
        comidinhas = comidinhas.filter{$0.isTarde == "true"}
        isTardeSelected = true
        self.comidinhasTableView.reloadData()
    }
    
    func filterNoite(){
        
        comidinhas = comidinhas.filter{$0.isNoite == "true"}
        isNoiteSelected = true
        self.comidinhasTableView.reloadData()
    }
    
    @IBAction func openFilter(_ sender: Any) {
        if filterTableView.isHidden == true{
            filterTableView.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                self.heightFilterConstraint.constant = 240 // heightCon is the IBOutlet to the constraint
                self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.heightFilterConstraint.constant = 0 // heightCon is the IBOutlet to the constraint
                self.view.layoutIfNeeded()
            }, completion: { finished in
                    self.filterTableView.isHidden = true
            })
            
        }
    }
    
}
extension ComidinhasViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

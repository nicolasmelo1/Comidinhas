//
//  Comidinhas.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 12/4/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class Comidinhas:Object{
    @objc dynamic var isManha = ""
    @objc dynamic var isTarde = ""
    @objc dynamic var isNoite = ""
    @objc dynamic var nomeVendedorComdidinhas = ""
    @objc dynamic var nomeProdutoComdidinhas = ""
    @objc dynamic var precoLabelComdidinhas = ""
    @objc dynamic var veganoComdidinhas = ""
    @objc dynamic var salgadoOuDoceComdidinhas = ""
    @objc dynamic var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

/*class Comidinhas {
    //Mark: Nomes
    var isManha: String
    var isTarde: String
    var isNoite: String
    var nomeVendedorComdidinhas: String
    var nomeProdutoComdidinhas: String
    var imagemProdutoComidinhas: UIImage
    var precoLabelComdidinhas: String
    var veganoComdidinhas: String
    var salgadoOuDoceComdidinhas: String
    
    init (isManha: String,
          isTarde: String,
          isNoite: String,
          nomeVendedorComdidinhas: String,
          nomeProdutoComdidinhas: String,
          imagemProdutoComidinhas: UIImage,
          precoLabelComdidinhas: String,
          veganoComdidinhas: String,
          salgadoOuDoceComdidinhas: String){
        
        
        
        
        
        self.isManha = isManha
        self.isNoite = isNoite
        self.isTarde = isTarde
        self.nomeVendedorComdidinhas = nomeVendedorComdidinhas
        self.nomeProdutoComdidinhas = nomeProdutoComdidinhas
        self.imagemProdutoComidinhas = imagemProdutoComidinhas
        self.precoLabelComdidinhas = precoLabelComdidinhas
        self.veganoComdidinhas = veganoComdidinhas
        self.salgadoOuDoceComdidinhas = salgadoOuDoceComdidinhas
    }
    
}*/

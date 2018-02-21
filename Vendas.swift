//
//  Vendas.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 12/4/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import Foundation
import UIKit

class Vendas{
    //MARK: Nomes
    var isRepeticao: Bool
    var isSegunda: String
    var isTerca: String
    var isQuarta: String
    var isQuinta: String
    var isSexta: String
    var isSabado: String
    var isDomingo: String
    var isManha: String
    var isTarde: String
    var isNoite: String
    var unidadesVendidas: String
    var nomeProdutoVendas: String
    var imagemProdutoVendas: UIImage
    var precoLabelVendas: String
    var veganoImagemVendas: String
    var salgadoOuDoceImagemVendas: String
    
    init (isSegunda: String,
          isTerca: String,
          isQuarta: String,
          isQuinta: String,
          isSexta: String,
          isSabado: String,
          isDomingo: String,
          isRepeticao: Bool,
          isManha: String,
          isTarde: String,
          isNoite: String,
          unidadesVendidas: String,
          nomeProdutoVendas: String,
          imagemProdutoVendas: UIImage,
          precoLabelVendas: String,
          veganoImagemVendas: String,
          salgadoOuDoceImagemVendas: String){
        
        self.isSegunda = isSegunda
        self.isTerca = isTerca
        self.isQuarta = isQuarta
        self.isQuinta = isQuinta
        self.isSexta = isSexta
        self.isSabado = isSabado
        self.isDomingo = isDomingo
        self.isRepeticao = isRepeticao
        self.isManha = isManha
        self.isTarde = isTarde
        self.isNoite = isNoite
        self.unidadesVendidas = unidadesVendidas
        self.nomeProdutoVendas = nomeProdutoVendas
        self.imagemProdutoVendas = imagemProdutoVendas
        self.precoLabelVendas = precoLabelVendas
        self.veganoImagemVendas = veganoImagemVendas
        self.salgadoOuDoceImagemVendas = salgadoOuDoceImagemVendas
    }
}

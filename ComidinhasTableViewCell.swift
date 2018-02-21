//
//  ComidinhasTableViewCell.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 12/4/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit

class ComidinhasTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var manha: UIView!
    @IBOutlet var nomeVendedor: UILabel!
    @IBOutlet var nomeProduto: UILabel!
    @IBOutlet var imagemProduto: UIImageView!
    @IBOutlet var precoLabel: UILabel!
    @IBOutlet var veganoImagem: UIImageView!
    @IBOutlet var salgadoOuDoceImagem: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        imagemProduto.layer.masksToBounds = false
        imagemProduto.layer.cornerRadius = imagemProduto.frame.height/2
        imagemProduto.clipsToBounds = true
        
    }

    
}



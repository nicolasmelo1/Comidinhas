//
//  VendasTableViewCell.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 12/4/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit

class VendasTableViewCell: UITableViewCell {

    //MARK: Variaveis
    
    @IBOutlet var manha: UIView!
    @IBOutlet var unidadesVendidas: UILabel!
    @IBOutlet var nomeProduto: UILabel!
    @IBOutlet var imagemProduto: UIImageView!
    @IBOutlet var precoLabel: UILabel!
    @IBOutlet var veganoImagem: UIImageView!
    @IBOutlet var salgadoOuDoceImagem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
        imagemProduto.layer.masksToBounds = false
        imagemProduto.layer.cornerRadius = imagemProduto.frame.size.width/2
        imagemProduto.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

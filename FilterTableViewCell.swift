//
//  FilterTableViewCell.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 29/5/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    

    @IBOutlet var filtro: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

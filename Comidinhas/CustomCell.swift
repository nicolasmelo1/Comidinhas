//
//  CustomCell.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 13/4/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit

protocol CustomCellDelegate {
    
    
    func textfieldTextWasChanged(_ newText: String, parentCell: CustomCell)
    
}

class CustomCell: UITableViewCell, UITextFieldDelegate {
    
    // MARK: IBOutlet Properties
    
    @IBOutlet var textNormalLabel: UILabel!
    @IBOutlet var fotoMenu: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var fotoUser: UIImageView!
    @IBOutlet var nadaLabel: UILabel!
    
    
    // MARK: Variables
    
    var delegate: CustomCellDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
           
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    // MARK: IBAction Functions
    
    // MARK: UITextFieldDelegate Function
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if delegate != nil {
            delegate.textfieldTextWasChanged(textField.text!, parentCell: self)
        }
        
        return true
    }
    
}


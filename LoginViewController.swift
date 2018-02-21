//
//  LoginViewController.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 30/3/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //MARK: Variaveis
    @IBOutlet var senhaTextField: UITextField!
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var registrarButton: UIButton!
    @IBOutlet var nhomButton: UIButton!
    @IBOutlet var facebookButton: UIButton!
    @IBOutlet var googleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Estilização Botões
        //Registrar Button
        registrarButton.backgroundColor = .clear
        registrarButton.layer.cornerRadius = 5
        registrarButton.layer.borderWidth = 1
        registrarButton.layer.borderColor = UIColor(red: 196.0/255.0, green: 190.0/255.0, blue: 165.0/255.0, alpha: 1.0).cgColor
        
        //Nhom Button
        nhomButton.layer.cornerRadius = 5
        
        //Facebook Button
        facebookButton.backgroundColor = .clear
        facebookButton.layer.cornerRadius = 5
        facebookButton.layer.borderWidth = 1
        facebookButton.layer.borderColor = UIColor.white.cgColor
        
        //Google Button
        googleButton.layer.cornerRadius = 5
       
        
        
        
        //MARK: Utilidades
        self.hideKeyboardWhenTappedAround()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}

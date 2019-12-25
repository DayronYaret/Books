//
//  SingUpViewController.swift
//  Books
//
//  Created by alumno on 18/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class SingUpViewController: UIViewController {
    
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var usernameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var addressInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    var ref: DatabaseReference!
    var singupmodel = SingupModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
        // Do any additional setup after loading the view.
    }
    
    func setUpElements() {
        //Ocultar el label de error
        errorLabel.alpha = 0
        
        
        //Damos estilo a los elementos
        Utilities.styleTextField(nameInput)
        Utilities.styleTextField(usernameInput)
        Utilities.styleTextField(emailInput)
        Utilities.styleTextField(addressInput)
        Utilities.styleTextField(passwordInput)
        
        Utilities.styleFilledButton(singUpButton)
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func singupTapped(_ sender: Any) {
        singupmodel.validateFields(name: nameInput.text!, username: usernameInput.text!, email: emailInput.text!, address: addressInput.text!, password: passwordInput.text!) { (error, text) in
            if(error == true){
                //mostramos el error en pantalla
                self.errorLabel.text = text
                self.errorLabel.alpha = 1
            }else{
                //creamos el usuario
                guard let name = self.nameInput.text else{return}
                guard let username = self.usernameInput.text else{return}
                guard let email = self.emailInput.text else{return}
                guard let address = self.addressInput.text else{return}
                guard let password = self.passwordInput.text else{return}
                
                
                self.singupmodel.createAccount(name: name, username: username, email: email, address: address, password: password) { (error) in
                    if( error == true){
                        self.errorLabel.text = "Error creating user"
                        self.errorLabel.alpha = 1
                    }else{
                        //Mandar al home screen
                        self.transitionToHome()
                    }
                }
                
            }
        }
    }
    
    func transitionToHome(){
        let mainTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainTabBarController) as? MainTabBarController
        
        view.window?.rootViewController = mainTabBarController
        view.window?.makeKeyAndVisible()
    }
}


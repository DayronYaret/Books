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
    func validatreFields()-> String?{
        
        //comprobamos si los campos estan llenos
        if(nameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            usernameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            emailInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            addressInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            passwordInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    @IBAction func singupTapped(_ sender: Any) {
        
        let error = validatreFields()
        
        if(error != nil){
            //mostramos el error en pantalla
            errorLabel.text = error!
            errorLabel.alpha = 1
        }else{
            //creamos el usuario
            guard let name = nameInput.text else{return}
            guard let username = usernameInput.text else{return}
            guard let email = emailInput.text else{return}
            guard let address = addressInput.text else{return}
            guard let password = passwordInput.text else{return}

            
            singupmodel.createAccount(name: name, username: username, email: email, address: address, password: password) { (error) in
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
    func transitionToHome(){
        let mainTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainTabBarController) as? MainTabBarController
               
               view.window?.rootViewController = mainTabBarController
               view.window?.makeKeyAndVisible()
    }
}


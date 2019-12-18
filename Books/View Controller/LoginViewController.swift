//
//  LoginViewController.swift
//  Books
//
//  Created by alumno on 18/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
    }
    
    func setUpElements(){
        //Ocultamos el label de error
        errorLabel.alpha = 0
        //Damos estilo a los elementos
        Utilities.styleTextField(emailInput)
        Utilities.styleTextField(passwordInput)
        Utilities.styleFilledButton(loginButton)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginTapped(_ sender: Any) {
        //Sing In
        let email = self.emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = self.passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if(error != nil){
                //No se puede iniciar sesion
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.alpha = 1
            }else{
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
    }
    
}

//
//  ViewController.swift
//  Books
//
//  Created by alumno on 18/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var singupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Auth.auth().currentUser)
        
        if(Auth.auth().currentUser != nil){
            print("hola")
            DispatchQueue.main.async {
                self.transitionToMain()

            }
        }else{
            print("adios")
            setUpElements()
        }

    }
    func setUpElements(){
        //Damos estilo a los elementos
        Utilities.styleFilledButton(singupButton)
        Utilities.styleFilledButton(loginButton)
    }
    
    func transitionToMain(){
            let mainTabBarController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainTabBarController) as? MainTabBarController
                           
             view.window?.rootViewController = mainTabBarController
             view.window?.makeKeyAndVisible()

        }

}


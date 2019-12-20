//
//  LoginModel.swift
//  Books
//
//  Created by alumno on 20/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//


import Foundation
import FirebaseAuth
import Firebase
class LoginModel {
    var error:Bool?
    var ref: DatabaseReference!

    func logIn(email:String, password:String, completion: @escaping (Bool, Error?) -> Void ){
                //Sing In
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if(error != nil){
                //No se puede iniciar sesion
                completion(true,error)
            }else{
               completion(false,error)
            }
        }
        
    }
}

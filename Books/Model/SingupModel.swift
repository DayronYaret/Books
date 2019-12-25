//
//  SingupModel.swift
//  Books
//
//  Created by alumno on 20/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
class SingupModel {
    var error:Bool?
    var ref: DatabaseReference!

    func createAccount(name:String, username:String ,email:String, address:String, password:String, completion: @escaping (Bool) -> Void ){
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)

        //creamos el usuario
         Auth.auth().createUser(withEmail: email, password: password) { (result,err) in
             
             if  (err != nil){
                completion(true)
                return
             }else{
                 //Usuario creado correctamente, añadir a la base de datos los valores de los inputs
                 self.ref = Database.database().reference()
                let user = ["name": name, "username": username, "email": email, "address": address, "password": password]
                 self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(user)
                completion(false)
             }
         }
    }
    func validateFields(name:String, username:String ,email:String, address:String, password:String, completion: @escaping (Bool,String) -> Void ) {
                //comprobamos si los campos estan llenos
        if(name.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            username.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            email.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            address.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines)==""){
            
            completion(true,"Please fill in all fields")
        }else{
            completion(false,"")

        }
        
    }
}

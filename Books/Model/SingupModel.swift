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
        
        
        //creamos el usuario
         Auth.auth().createUser(withEmail: email.trimmingCharacters(in: .whitespacesAndNewlines), password: password.trimmingCharacters(in: .whitespacesAndNewlines)) { (result,err) in
             
             if  (err != nil){
                completion(true)
                return
             }else{
                 //Usuario creado correctamente, añadir a la base de datos los valores de los inputs
                 self.ref = Database.database().reference()
                 var user = ["name": name, "username": username, "email": email, "address": address, "password": password]
                 self.ref.child("users").child(Auth.auth().currentUser!.uid).setValue(user)
                 print(self.ref)
                completion(false)
             }
         }
    }
}

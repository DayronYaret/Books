//
//  HomeModel.swift
//  Books
//
//  Created by alumno on 23/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
class HomeModel {
    var bookItemArrayList: [BookItem] = []
    var cantidad:Int?
    var filter:[BookItem] = []
    func fillArray(completion: @escaping (Bool, [BookItem]) -> Void){
        let ref = Database.database().reference().child("allBooks")
        ref.observe(.value, with: { (snapshot) in
            
            var bookItemArrayList1 : [BookItem] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                    let book = BookItem(snapshot: snapshot){
                    print(book)
                    bookItemArrayList1.append(book)
                    
                }
            }
            self.cantidad = bookItemArrayList1.count
            self.bookItemArrayList = bookItemArrayList1
            completion(false,self.bookItemArrayList)
            Constants.Values.array = self.bookItemArrayList
                    
        })
    
    }
    
    func wantIt(author:String,image:String,user:String,isbn:String,title:String,correo:String, completion:@escaping (Bool)->Void){
        let ref = Database.database().reference()
        let currentUser = Auth.auth().currentUser!.uid
        //Añadimos a base de datos de libros que te gustan
        var book = ["autor": author, "image": image, "isbn": isbn, "title": title, "user": user, "correo": correo]
        ref.child("BooksILike").child(currentUser).child(title+"_"+isbn).setValue(book)
        //Añadimos a base de datos de likes
        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let userData = value![currentUser] as! NSDictionary
            let userUsername = userData["username"]
            let publisherData = value![user] as! NSDictionary
            let publisherUsername = publisherData["username"]
            var like = ["publisher":publisherUsername,"title":title,"user":userUsername]
            ref.child("Likes").child(user).child(currentUser).setValue(like)
            completion(false)
        }
        
    }

}


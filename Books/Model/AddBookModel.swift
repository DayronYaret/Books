//
//  AddBookModel.swift
//  Books
//
//  Created by alumno on 24/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
class AddBookModel{
    func addBook(autor:String,title:String,isbn:String,image:UIImage, completion: @escaping (Bool) -> Void){
        let ref = Database.database().reference()
        let currentUser = Auth.auth().currentUser?.uid
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if(snapshot.childSnapshot(forPath: "booksUser/"+currentUser!).hasChild(isbn)){
                completion(true)
            }else{
                let storage = Storage.storage()
                let path1 = "image/"+currentUser!
                let path2 = "/"+title+".jpg"
                let str = storage.reference(withPath: path1+path2)
                
                let uploadTask = str.putData(image.pngData()!, metadata: nil){ (metadata, error) in
                    guard let metadata = metadata else {
                        return
                    }
                    let size = metadata.size
                    str.downloadURL { (url, error) in
                        guard let downloadURL = url else{
                            return
                        }
                        let book = BookItem(author: autor, image: String(url!.absoluteString), isbn: isbn, title: title, user: currentUser!, correo: snapshot.childSnapshot(forPath: "users/"+currentUser!+"/email/").value as! String)
                        print( snapshot.childSnapshot(forPath:"users/"+currentUser!+"/email/").value!)
                        
                        let dictionary = ["autor": autor, "image": String(url!.absoluteString), "isbn": isbn, "title": title, "user": currentUser!, "correo": snapshot.childSnapshot(forPath: "users/"+currentUser!+"/email/").value as! String]
                        ref.child("booksUser").child(currentUser!).child(book.title+"_"+book.isbn).setValue(dictionary)
                        ref.child("allBooks").child(currentUser!+"_"+book.title+"_"+book.isbn).setValue(dictionary)
                        completion(false)
                    }
                }
            }
        }
    }
    func validateFields(image: UIImageView,title:String,author:String,isbn:String, completion: @escaping (Bool,String) -> Void ) {
                //comprobamos si los campos estan llenos
        if(title.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            author.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            isbn.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            image.image == (UIImage(named: ""))){
            
            completion(true,"Please fill in all fields")
        }else{
            completion(false,"")

        }
        
    }
    
}


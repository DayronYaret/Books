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
class HomeModel {
    var bookItemArrayList: [BookItem] = []
    var cantidad:Int?
    func fillArray(completion: @escaping (Bool, [BookItem]) -> Void){
        let ref = Database.database().reference().child("allBooks")
        ref.observe(.value, with: { (snapshot) in
            
            var bookItemArrayList1 : [BookItem] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                    let book = BookItem(snapshot: snapshot){
                    bookItemArrayList1.append(book)
                    
                }
            }
            self.cantidad = bookItemArrayList1.count
            self.bookItemArrayList = bookItemArrayList1
            completion(false,self.bookItemArrayList)
                    
        })
    
    }
}


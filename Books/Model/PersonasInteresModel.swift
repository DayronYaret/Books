//
//  PersonasInteresModel.swift
//  Books
//
//  Created by alumno on 23/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
class PersonasInteresModel {
    var likeArrayList: [Likes] = []
    func fillArray(completion: @escaping (Bool, [Likes]) -> Void){
        let currentUser = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("Likes").child(currentUser!)
        ref.observe(.value, with: { (snapshot) in
            
            var LikeArrayList1 : [Likes] = []
            for child in snapshot.children{
                if let snapshot = child as? DataSnapshot,
                    let like = Likes(snapshot: snapshot){
                    LikeArrayList1.append(like)
                    
                }
            }
            self.likeArrayList = LikeArrayList1
            completion(false,self.likeArrayList)
                    
        })
    
    }
}


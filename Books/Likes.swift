//
//  BookItem.swift
//  Books
//
//  Created by alumno on 23/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//
import Foundation
import Firebase
struct Likes {
    
    let ref: DatabaseReference?
    let publisher:String
    let title:String
    let currentUser:String
    let key:String
    
    init(publisher:String,title:String,currentUser:String, key:String = "") {
        self.ref = nil
        self.key = key
        self.publisher = publisher
        self.currentUser = currentUser
        self.title = title
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let publisher = value["publisher"] as? String,
            let title = value["title"] as? String,
            let user = value["user"] as? String
            else {return nil}
        
        
        self.key = snapshot.key
        self.ref = snapshot.ref
        self.publisher = publisher
        self.title = title
        self.currentUser = user
    }
    
    func toAnyObject() -> Any {
        return [
            "publisher" : publisher,
            "title" : title,
            "user" : currentUser
        ]
    }
}

//
//  BookItem.swift
//  Books
//
//  Created by alumno on 23/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//
import Foundation
import Firebase
struct BookItem {
    
    let ref: DatabaseReference?
    let author:String
    let image:String
    let correo:String
    let isbn:String
    let title:String
    let user:String
    let key:String
    
    init(author:String, image:String, isbn:String, title:String, user:String, correo:String, key:String = "") {
        self.ref = nil
        self.key = key
        self.author = author
        self.image = image
        self.isbn = isbn
        self.title = title
        self.user = user
        self.correo = correo
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let author = value["autor"] as? String,
            let correo = value["correo"] as? String,
            let image = value["image"] as? String,
            let isbn = value["isbn"] as? String,
            let title = value["title"] as? String,
            let user = value["user"] as? String
            else {return nil}
        self.key = snapshot.key
        self.ref = snapshot.ref
        self.author = author
        self.image = image
        self.correo = correo
        self.isbn = isbn
        self.user = user
        self.title = title
    }
    
    func toAnyObject() -> Any {
        return [
            "autor" : author,
            "correo" : correo,
            "image" : image,
            "isbn" : isbn,
            "title" : title,
            "user" : user
        ]
    }
}

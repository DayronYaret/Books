//
//  AlertMyBooksService.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit
class AlertMyBooksService{
    
    func alert(image:UIImage,title:String,author:String, isbn:String , user: String, correo :String, imageUrl:String)-> AlertMyBooksViewController{
        let storyboard = UIStoryboard(name: "AlertMyBooksStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: "AlertMyBooksVC") as! AlertMyBooksViewController
        
        alertVC.author = author
        alertVC.titleText = title
        alertVC.imagen = image
        alertVC.isbn = isbn
        alertVC.user = user
        alertVC.correo = correo
        alertVC.imageUrl = imageUrl
        return alertVC
    }
}

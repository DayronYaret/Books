//
//  AlertInteresService.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//
import Foundation
import UIKit
class AlertInteresService{
    
    func alert(image:UIImage,title:String,author:String, isbn:String , user: String, correo :String)-> AlertInteresViewController{
        let storyboard = UIStoryboard(name: "AlertInteresStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: "AlertInteresVC") as! AlertInteresViewController
        
        alertVC.author = author
        alertVC.titleText = title
        alertVC.imagen = image
        alertVC.isbn = isbn
        alertVC.user = user
        alertVC.correo = correo
        return alertVC
    }
}

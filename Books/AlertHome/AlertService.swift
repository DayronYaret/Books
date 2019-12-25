//
//  AlertService.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit
class AlertService{
    
    
    func alert(image:UIImage,title:String,author:String, isbn:String , user: String, correo :String, imageURL:String, completion: @escaping ()->Void)-> AlertViewController{
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: "AlertVC") as! AlertViewController
        
        alertVC.author = author
        alertVC.titleText = title
        alertVC.imagen = image
        alertVC.isbn = isbn
        alertVC.user = user
        alertVC.correo = correo
        alertVC.imageURL = imageURL
        alertVC.userButtonAction = completion
        
        return alertVC
    }
}

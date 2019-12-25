//
//  AlertProfileService.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation
import UIKit
class AlertProfileService{
    
    func alert(image:UIImage,title:String,author:String, isbn:String , user: String, correo :String, imageURL:String)-> AlertProfileViewController{
        let storyboard = UIStoryboard(name: "AlertProfileStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: "AlertProfileVC") as! AlertProfileViewController
        
        alertVC.author = author
        alertVC.titleText = title
        alertVC.imagen = image
        alertVC.isbn = isbn
        alertVC.user = user
        alertVC.correo = correo
        alertVC.imageURL = imageURL
        
        return alertVC
    }
}

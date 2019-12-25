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
    
    func alert(image:UIImage,title:String,author:String)-> AlertViewController{
        let storyboard = UIStoryboard(name: "AlertStoryboard", bundle: .main)
        let alertVC = storyboard.instantiateViewController(identifier: "AlertVC") as! AlertViewController
        
        alertVC.author = author
        alertVC.titleText = title
        alertVC.imagen = image
        
        return alertVC
    }
}

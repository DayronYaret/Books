//
//  Users.swift
//  Pem13
//
//  Created by Carlos on 12/17/19.
//  Copyright © 2019 Carlos. All rights reserved.
//

import Foundation

class User {
    
    var name :String
    var username:String
    var email:String
    var address:String
    var password:String
    init(name: String, username : String, email : String, address : String, password: String ){
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.password = password
    }
    
}

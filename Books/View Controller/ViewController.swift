//
//  ViewController.swift
//  Books
//
//  Created by alumno on 18/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var singupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
    }
    func setUpElements(){
        //Damos estilo a los elementos
        Utilities.styleFilledButton(singupButton)
        Utilities.styleFilledButton(loginButton)
    }

}


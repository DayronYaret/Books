//
//  AddBookViewController.swift
//  Books
//
//  Created by alumno on 23/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    @IBOutlet weak var addBookButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var titleInput: UITextField!
    @IBOutlet weak var authorInput: UITextField!
    @IBOutlet weak var isbnInput: UITextField!
    var addBookModel = AddBookModel()
    var imagePicker:ImagePicker!
    
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        //Damos estilo a los elementos
        setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp(){
        errorLabel.alpha = 0
        Utilities.styleFilledButton(addBookButton)
        Utilities.styleTextField(titleInput)
        Utilities.styleTextField(isbnInput)
        Utilities.styleTextField(authorInput)
        
        //escondemos tabbar
        
        
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        addBookModel.validateFields(image:image, title: titleInput.text!, author: authorInput.text!, isbn: isbnInput.text!) { (error, text) in
            if(error){
                self.errorLabel.alpha = 1
                self.errorLabel.text = text
            }else{
                self.addBookModel.addBook(autor: self.authorInput.text!, title: self.titleInput.text!, isbn: self.isbnInput.text!, image: self.image.image!) { (error) in
                    if(error == false){
                        self.errorLabel.text = "Se ha añadido el libro"
                        self.errorLabel.alpha = 1
                        let mainTabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainTabBarController) as? MainTabBarController
                                       
                         self.view.window?.rootViewController = mainTabBarController
                         self.view.window?.makeKeyAndVisible()
                        
                    }else{
                        self.errorLabel.text = error.description
                        self.errorLabel.alpha = 1
                    }
                }
            }
        }
    }
    @IBAction func addPhoto(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
}

extension AddBookViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.image.image = image}
}

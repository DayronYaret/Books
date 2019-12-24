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
    
    func validatreFields()-> String?{
        
        //comprobamos si los campos estan llenos
        if(titleInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            authorInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            isbnInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)=="" ||
            image.image == UIImage(named: "photo")
            ){
            return "Please fill in all fields"
        }
        
        return nil
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let error = validatreFields()
        if(error != nil){
            errorLabel.alpha = 1
            errorLabel.text = error
            
        }else{
            addBookModel.addBook(autor: authorInput.text!, title: titleInput.text!, isbn: isbnInput.text!, image: image.image!) { (error) in
                if(error == false){

                    
                }else{
                    self.errorLabel.text = error.description
                    self.errorLabel.alpha = 1
                }
                }
            }
    }
    @IBAction func addPhoto(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddBookViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.image.image = image}
}

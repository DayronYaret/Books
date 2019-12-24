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
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func addButtonTapped(_ sender: Any) {
        let error = validatreFields()
        if(error != nil){
            errorLabel.alpha = 1
            errorLabel.text = error
        }else{
            
        }
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

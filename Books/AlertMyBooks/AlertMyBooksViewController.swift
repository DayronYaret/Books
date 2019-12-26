//
//  AlertMyBooksViewController.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class AlertMyBooksViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    let ref = Database.database().reference()
    var author: String = ""
    var titleText: String = ""
    var imagen: UIImage!
    var isbn:String = ""
    var user:String = ""
    var correo:String = ""
    var imageUrl:String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp(){
          titleLabel.text = titleText
          authorLabel.text = author
          image.image = imagen
      }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let currentUser = Auth.auth().currentUser?.uid
        ref.child("allBooks").child(currentUser!+"_"+titleText+"_"+isbn).removeValue()
        ref.child("booksUser").child(currentUser!).child(titleText+"_"+isbn).removeValue()

        dismiss(animated: true)
    }
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
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

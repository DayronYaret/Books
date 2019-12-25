//
//  AlertInteresViewController.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class AlertInteresViewController: UIViewController {


    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!

    let interesView = LibrosInteresViewController()
    let interesModel = LibrosInteresModel()
    let ref = Database.database().reference()
    var author: String = ""
       var titleText: String = ""
       var imagen: UIImage!
       var isbn:String = ""
       var user:String = ""
       var correo:String = ""
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

    @IBAction func notInterestedTapped(_ sender: Any) {
        let currentUser = Auth.auth().currentUser?.uid
        ref.child("BooksILike").child(currentUser!).child(titleText+"_"+isbn).removeValue()

        dismiss(animated: true)
    }
    @IBAction func goToUserProfileTapped(_ sender: Any) {
        dismiss(animated: true)

    }

    @IBAction func contactTapped(_ sender: Any) {
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

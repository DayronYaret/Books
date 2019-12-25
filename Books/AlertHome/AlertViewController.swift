//
//  AlertViewController.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import MessageUI
class AlertViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var author: String = ""
    var titleText: String = ""
    var imagen: UIImage!
    var isbn:String = ""
    var user:String = ""
    var correo:String = ""
    var imageURL: String = ""
    
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
    

    @IBAction func wantItTapped(_ sender: Any) {
        let ref = Database.database().reference()
        let currentUser = Auth.auth().currentUser!.uid
        //Añadimos a base de datos de libros que te gustan
        var book = ["autor": author, "image": imageURL, "isbn": isbn, "title": titleText, "user": user, "correo": correo]
        ref.child("BooksILike").child(currentUser).child(titleText+"_"+isbn).setValue(book)
        //Añadimos a base de datos de likes
        ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let userData = value![currentUser] as! NSDictionary
            let userUsername = userData["username"]
            let publisherData = value![self.user] as! NSDictionary
            let publisherUsername = publisherData["username"]
            var like = ["publisher":publisherUsername,"title":self.titleText,"user":userUsername]
            ref.child("Likes").child(self.user).child(currentUser).setValue(like)
        }
        //print(ref.child("users").child(currentUser).value(forKey: "username"))
        //let user2 = ref.child("users").child(currentUser).value(forKey: "username")
        //var like = ["publisher":publisher,"title":titleText,"user":user2]
        //ref.child("Likes").child(user).child(currentUser).setValue(like)
        dismiss(animated: true)
    }
    @IBAction func goToUserProfileTapped(_ sender: Any) {
        dismiss(animated: true)

    }
    @IBAction func contactWithTheUserTapped(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController(to: correo, title: titleText)
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
        }
    }
    @IBAction func backTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func configuredMailComposeViewController(to:String,title:String) -> MFMailComposeViewController {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
    
            mailComposerVC.setToRecipients([to])
            mailComposerVC.setSubject("Interesado en: \(self.titleText)")
        mailComposerVC.setMessageBody("", isHTML: true)
    
            return mailComposerVC
        }
    
    
       // MARK: MFMailComposeViewControllerDelegate Method
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
           controller.dismiss(animated: true, completion: nil)
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

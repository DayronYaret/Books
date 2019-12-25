//
//  AlertViewController.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    var author: String = ""
    var titleText: String = ""
    var imagen: UIImage!
    
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
        dismiss(animated: true)
    }
    @IBAction func goToUserProfileTapped(_ sender: Any) {
        dismiss(animated: true)

    }
    @IBAction func contactWithTheUserTapped(_ sender: Any) {
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

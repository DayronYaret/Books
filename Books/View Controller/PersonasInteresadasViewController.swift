//
//  PersonasInteresadasViewController.swift
//  Books
//
//  Created by alumno on 20/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase
class PersonasInteresadasViewController: UIViewController, UITableViewDataSource {
    
    var personasInteresModel = PersonasInteresModel()
    var storage = Storage.storage()
    var likeArrayList : [Likes] = []
    var cantidad:Int = 0
    let ref = Database.database().reference(withPath: "Likes")
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        
        //llenamos el array
        refreshView()
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell")
        DispatchQueue.global().async { [weak self] in
            self!.personasInteresModel.fillArray { (error, array) in
                if(error == false){
                            DispatchQueue.main.async {
                                cell?.textLabel?.text = array[indexPath.row].currentUser
                                cell?.detailTextLabel?.text = "está interesado en: " + array[indexPath.row].title
                                print(array.count, "cantidad")
                                
                            }
                        }
                    self?.likeArrayList = array
                    
                }
                
            }
        
        return cell!
    }
    
    func refreshView(){
        personasInteresModel.fillArray { (error, array) in
            if(error == false){
                self.likeArrayList = array
                self.tableView.reloadData()
            }
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

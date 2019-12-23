//
//  HomeViewController.swift
//  Books
//
//  Created by alumno on 18/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let dataArray = ["AAA","BBB","CCC","DDD"]

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //Register cells
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
    }
    
    @IBAction func logOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do{
            try firebaseAuth.signOut()
            transitionToMain()
            
        }catch let signOutError as NSError {
            print("Error singin out: %@",signOutError)
        }
        
    }
    
    func transitionToMain(){
        let mainViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController) as? ViewController
               
               view.window?.rootViewController = mainViewController
               view.window?.makeKeyAndVisible()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.setData(image: "logo", author: self.dataArray[indexPath.row], title: self.dataArray[indexPath.row])
        return cell
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

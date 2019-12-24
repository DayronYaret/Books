//
//  HomeViewController.swift
//  Books
//
//  Created by alumno on 18/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase
class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var homeModel = HomeModel()
    var storage = Storage.storage()
    var bookItemArrayList : [BookItem] = []
    var image:UIImage?
    var cantidad:Int = 0
    let ref = Database.database().reference(withPath: "allBooks")
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //Register cells
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        //Damos forma al botton de añadir

        addButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        addButton.layer.cornerRadius = 0.5 * addButton.bounds.size.width
        addButton.clipsToBounds = true
        //llenamos el array
        refreshView()
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
        
        return bookItemArrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
            DispatchQueue.global().async { [weak self] in
            self!.homeModel.fillArray { (error, array) in
                if(error == false){
                    let url = URL(string:array[indexPath.row].image)
                    if let data = try? Data(contentsOf: url!) {
                      if let image = UIImage(data: data) {
                          DispatchQueue.main.async {
                              cell.setData(image: image, author: array[indexPath.row].author, title: array[indexPath.row].title)
                            print(array.count, "cantidad")
                            
                        }
                      }
                      else
                      {
                          print("Fallo en la descarga de la imagen")
                      }
                      
                  }
                    self?.bookItemArrayList = array

                }
                
            }
  
        }
        
        return cell
    }
    
    func refreshView(){
        homeModel.fillArray { (error, array) in
            if(error == false){
                self.bookItemArrayList = array
                self.collectionView.reloadData()
            }
        }
    }
        
}




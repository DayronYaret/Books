//
//  ProfileViewController.swift
//  Books
//
//  Created by alumno on 25/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase
class ProfileViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    let alertService = AlertProfileService()
    var user:String!
    var profileModel = ProfileModel()
    var bookItemArrayList :[BookItem] = []
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Constants.Values.user
        
        setLabel()
        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        
        //Register cells
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        refreshView()
    }
    func setLabel(){
        profileModel.getUsername(user: user) { (error, username) in
            if(!error){
                self.usernameLabel.text = username
            }
        }
    }
    
    @IBAction func backTapped(_ sender: Any) {
        let mainTabBarController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainTabBarController) as? MainTabBarController
                       
         self.view.window?.rootViewController = mainTabBarController
         self.view.window?.makeKeyAndVisible()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookItemArrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          //usamos la view que creamos
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
              //Añadimos la opcion de pulsar en el collectionViewCell
             cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
              
              DispatchQueue.global().async { [weak self] in
                self!.profileModel.fillArray(user: self!.user!) { (error, array) in
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
        profileModel.fillArray(user: self.user) { (error, array) in
            if(error == false){
                self.bookItemArrayList = array
                self.collectionView.reloadData()
            }
        }
        
    }
    @objc func tap(_ sender: UITapGestureRecognizer) {
           
           let location = sender.location(in: self.collectionView)
           let indexPath = self.collectionView.indexPathForItem(at: location)
           
           if let index = indexPath {
               
               let cell = self.bookItemArrayList[index.row]
               DispatchQueue.main.async {
                   let vc = ProfileViewController()
                   vc.user = cell.user
                   
               }

               let url = URL(string:cell.image)
               if let data = try? Data(contentsOf: url!) {
                   if let image = UIImage(data: data) {
                       let alertVC = alertService.alert(image: image, title: cell.title,author: cell.author, isbn: cell.isbn, user: cell.user, correo: cell.correo,imageURL: cell.image)
                       present(alertVC,animated: true)
                       
                   }
               }
               
           }
       }

}

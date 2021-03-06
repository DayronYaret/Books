//
//  MisLibrosViewController.swift
//  Books
//
//  Created by alumno on 20/12/2019.
//  Copyright © 2019 Carlos. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Firebase
class LibrosInteresViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var librosInteresModel = LibrosInteresModel()
    var storage = Storage.storage()
    let alertService = AlertInteresService()
    var bookItemArrayList : [BookItem] = []
    var image:UIImage?
    var cantidad:Int = 0
    let ref = Database.database().reference(withPath: "booksUser")
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        
        //Register cells
        self.collectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        //llenamos el array
        refreshView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookItemArrayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        //Añadimos la opcion de pulsar en el collectionViewCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        //Añadimos la opcion de pulsar en el collectionViewCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        DispatchQueue.global().async { [weak self] in
            self!.librosInteresModel.fillArray { (error, array) in
                if(error == false){
                    self!.bookItemArrayList = array
                    if (indexPath.row < self!.bookItemArrayList.count) {
                        DispatchQueue.main.async {
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
                            
                        }
                    }
                    
                }
                
            }
        }
        
        return cell
    }
    
    func refreshView(){
        librosInteresModel.fillArray { (error, array) in
            if(error == false){
                self.bookItemArrayList = array
                self.collectionView.reloadData()
            }
        }
    }
    //funcion al pulsar la cell
    @objc func tap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            print("Got clicked on index: \(index)!")
            let cell = self.bookItemArrayList[index.row]
            let url = URL(string:cell.image)
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    let alertVC = alertService.alert(image: image, title: cell.title,author: cell.author, isbn: cell.isbn, user: cell.user, correo: cell.correo, imageURL: cell.image){
                        Constants.Values.user = cell.user
                        let profileViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.profileViewController) as? ProfileViewController
                        
                        self.view.window?.rootViewController = profileViewController
                        self.view.window?.makeKeyAndVisible()
                    }
                    present(alertVC,animated: true)
                    
                }
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

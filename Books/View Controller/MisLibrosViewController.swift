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
class MisLibrosViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    var myBooksModel = MisLibrosModel()
    var storage = Storage.storage()
    var bookItemArrayList : [BookItem] = []
    let alertService  = AlertMyBooksService()
    var image:UIImage?
    var cantidad:Int = 0
    let ref = Database.database().reference(withPath: "booksUser")
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.dataSource = self
        
        
        //Damos forma al botton de añadir
        addButton.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
               addButton.layer.cornerRadius = 0.5 * addButton.bounds.size.width
               addButton.clipsToBounds = true
        
        //volvemos a poner el tabbar

        
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
        
        
                   DispatchQueue.global().async { [weak self] in
                   self!.myBooksModel.fillArray { (error, array) in
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
        myBooksModel.fillArray { (error, array) in
            if(error == false){
                self.bookItemArrayList = array
                self.collectionView.reloadData()
            }
        }
    }
    
    
    //funcion al pulsar la cell
    @objc func tap(_ sender: UITapGestureRecognizer) {
    
       let location = sender.location(in: self.collectionView)
       let indexPath = self.collectionView.indexPathForItem(at: location)
    
       if let index = indexPath {
          let cell = self.bookItemArrayList[index.row]
          let url = URL(string:cell.image)
          if let data = try? Data(contentsOf: url!) {
              if let image = UIImage(data: data) {
                  let alertVC = alertService.alert(image: image, title: cell.title,author: cell.author, isbn: cell.isbn, user: cell.user, correo: cell.correo)
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

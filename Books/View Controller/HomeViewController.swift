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

class HomeViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating	 {
    //variables para buscar
    var filtered:[BookItem] = []
    var searchActive : Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    var array:[BookItem] = []
    
    let homeModel = HomeModel()
    let alertService = AlertService()
    var storage = Storage.storage()
    var bookItemArrayList : [BookItem] = []
    var image:UIImage?
    var user:String?
    
    let ref = Database.database().reference(withPath: "allBooks")
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var addButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Search setup
        
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
        homeModel.fillArray { (error, array) in
            if(!error){
                self.bookItemArrayList = array
                self.collectionView.reloadData()
            }
        }
    }
    @IBAction func search(_ sender: Any) {
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for tools and resources"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    func transitionToMain(){
        let mainViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainViewController) as? ViewController
        
        view.window?.rootViewController = mainViewController
        view.window?.makeKeyAndVisible()
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchActive {
            return filtered.count
        }
        else
        {
            return bookItemArrayList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //usamos la view que creamos
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        //Añadimos la opcion de pulsar en el collectionViewCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        
        if(searchActive == true){
            array = Constants.Values.array
        }else{
            array = bookItemArrayList
        }
        let url = URL(string:array[indexPath.row].image)
        if let data = try? Data(contentsOf: url!) {
            if let image = UIImage(data: data) {
                cell.setData(image: image, author: self.array[indexPath.row].author, title: self.array[indexPath.row].title)
                
                
            }
            else
            {
                print("Fallo en la descarga de la imagen")
            }
            
        }
        
        return cell
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
                    let alertVC = alertService.alert(image: image, title: cell.title,author: cell.author, isbn: cell.isbn, user: cell.user, correo: cell.correo,imageURL: cell.image){
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
    //MARK: SearchBar
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func updateSearchResults(for searchController: UISearchController)
    {
        let searchString = searchController.searchBar.text
        filtered = bookItemArrayList.filter({ (BookItem) -> Bool in
            let countryText: NSString = BookItem.title as! NSString
            return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        Constants.Values.array = filtered
        collectionView.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    
}




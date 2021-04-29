//
//  ViewController.swift
//  BookStore
//
//  Created by itsector on 23/04/2021.
//

import UIKit


class ViewController: UIViewController {
    
    //MARK: Properties
    //set book data
    private var api: NetworkManager!
    private var booksData = [BooksData]()
    private var apiCall = [NetworkManager]()
    var books: [BooksData] = []
    
    
    let url = "https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0"

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getData { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.success(let books):
                self.books = books
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }

        
    
//        let layout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: 129, height: 120)
//        collectionView.register(BookCollectionViewCell.nib(), forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
    
    }
//    func updateUI() -> <#return type#> {
//        <#function body#>
//    }
    
}

    extension ViewController: UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            
        }
    }

    extension ViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return booksData.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BooksCollectionViewCell

            let book = books[indexPath.item]
            cell.thumbnail = nil
            

           
            return cell


        }
    }

    //custom layouts
    extension ViewController: UICollectionViewDelegateFlowLayout{

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 120, height: 120)
        }
    }



  
    
        
     
    

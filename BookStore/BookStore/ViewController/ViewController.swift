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
    private var apiCall = [NetworkManager]()
    private var booksDataSource: [Items] = []
    
    var page = 0
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
   
        getBooksPage(page: page)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        //        let layout = UICollectionViewFlowLayout()
        //        layout.itemSize = CGSize(width: 129, height: 120)
        //        collectionView.register(BookCollectionViewCell.nib(), forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        //        collectionView.delegate = self
        //        collectionView.dataSource = self
        
    }
    
    
    func getBooksPage(page: Int) {
        NetworkManager.shared.getData(page: page) { [weak self] result in
            guard let self = self else { return }
         
            
            switch result {
            case .success(let books):
                self.updateUI(with: books)
            case .failure(let error):
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
                
            }
        }
    }
    func updateUI(with books: [Items]) {
      let here = booksDataSource.append(contentsOf: books)
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
        
    }
    
}



extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //go to deatil View of books
        
        
    }
}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return booksDataSource.count
    }


func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! BooksCollectionViewCell
    let book = booksDataSource[indexPath.row]
    //set cell with images
    cell.set(book: book)
    return cell
}


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.destination is DetailViewController {
        
    }
 }
}

//custom layouts
//extension ViewController: UICollectionViewDelegateFlowLayout{
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 120, height: 120)
//    }
//}
//
////MARK: - convert data to imageView
//
//func getUIImageFromData(_ data: Data) -> UIImage? {
//    return UIImage(data: data)
//}













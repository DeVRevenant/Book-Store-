//
//  ViewController.swift
//  BookStore
//
//  Created by itsector on 23/04/2021.
//

import UIKit


class BooksListingViewController: UIViewController {
    
    //MARK: Properties
    var items: [Items] = []
    var bookIndex = 0
    var isWaiting = false
    var isEdit = false
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        getBooks()
    }
    
    func getBooks() {
        NetworkManager.shared.getData(pageIndex: bookIndex) { [weak self] result in
            //
            guard let self = self else { return }
            switch result {
            case.success(let books):
                DispatchQueue.main.async {
                    self.items.append(contentsOf: books.items)
                    if self.bookIndex == 0 {
                        self.collectionView.reloadData()
                    } else {
                        self.collectionView.reloadSections([0]) // it means that are reloading collection view but not going on top.
                    }
                }
            case.failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription , preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            self.isWaiting = false
        }
    }
    


//MARK: - ACTION
    
    func gotoDetailScreen(_ bookItem: Items) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BookDetailViewController") as! BookDetailViewController
        vc.bookItem = bookItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    @IBAction func tappedAddFavourite(_ sender: Any) {
        
    }
    
   
    
}

extension BooksListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        gotoDetailScreen(item)
    }
}

extension BooksListingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BooksCollectionViewCell
        let item = items[indexPath.item]
        cell.imgViewWidthConst.constant = (collectionView.frame.width / 2) - 10
        if let thumbnail = item.volumeInfo.imageLinks?.thumbnail {
            cell.imgView.loadImageUsingCache(withUrl: thumbnail)
        } else {
            cell.imgView.image = UIImage(named: "empty")
        }
        return cell
        
    }
}

extension BooksListingViewController: UICollectionViewDelegateFlowLayout{
    
}

extension BooksListingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let verticalOffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - verticalOffset
        if distanceFromBottom < height, !isWaiting {
            isWaiting = true
            self.bookIndex += 1
            self.getBooks()
        }
    }
}





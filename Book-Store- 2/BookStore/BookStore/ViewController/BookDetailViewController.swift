//
//  BookDetailViewController.swift
//  BookStore
//
//  Created by itsector on 03/05/2021.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookItem: Items?
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var authorLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    
    
    let favouriteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateDetails()
    }
    @IBAction func didTapBuyBtn(_ sender: Any) {
      openBuyLink()
    }
    
    func openBuyLink() {
        if let item = bookItem, let url = URL(string:item.saleInfo.buyLink ?? "" ) {
            UIApplication.shared.open(url)
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Sorry", message: "This item is not available yet" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func populateDetails() {
        guard let data = bookItem else { return }
        if let url = data.volumeInfo.imageLinks?.thumbnail {
            imgView.loadImageUsingCache(withUrl: url)
        }
        titleLbl.text = data.volumeInfo.title
        authorLbl.text = data.volumeInfo.authors?.joined(separator: "\n")
        detailsLbl.text = data.volumeInfo.description
    }
    
//    private func configureAddFacouriteButton() {
//        view.addSubview(favouriteButton)
//
//        // say to iOS not to create Auto Layout automatically
//        favouriteButton.translatesAutoresizingMaskIntoConstraints =  false
//        favouriteButton.setTitleColor(.systemBlue, for: .normal)
//        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
//
//        NSLayoutConstraint.activate([
//            favouriteButton.topAnchor.constraint(equalTo: detailsLbl.topAnchor, constant: 0),
//            favouriteButton.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            favouriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            favouriteButton.heightAnchor.constraint(equalToConstant: 40)
//        ])
//
//    }
    
    //MARK: - Actions
    
    @objc private func favouriteButtonTapped() {
        
    }
}

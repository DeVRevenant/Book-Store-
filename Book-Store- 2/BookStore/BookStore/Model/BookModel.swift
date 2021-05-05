//
//  DataBooks.swift
//  BookStore
//
//  Created by itsector on 25/04/2021.
//

import Foundation

struct BooksData: Codable {
    var kind: String
    var totalItems: Int
    var items: [Items]
}

struct Items: Codable {
    var volumeInfo: VolumeInfo
    var saleInfo: SaleInfo
}

struct SaleInfo: Codable {
    var buyLink: String?
}


struct VolumeInfo: Codable {
    var title: String
    var authors: [String]?
    var description: String?
    var imageLinks: ImageThumbnail?
}


struct ImageThumbnail: Codable {
    var thumbnail: String?
}

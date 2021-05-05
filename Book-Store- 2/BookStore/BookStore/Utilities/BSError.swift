//
//  Error.swift
//  BookStore
//
//  Created by itsector on 03/05/2021.
//

import Foundation

enum BSError: String, Error {
    case invalidURL         = "This URL is not valid."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this book. Please try again."
    case alreadyInFavorites = "You've already favorited this book."
}

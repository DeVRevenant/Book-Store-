//
//  NetworkManager.swift
//  BookStore
//
//  Created by itsector on 27/04/2021.
//

import Foundation




enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case vadLocalUrl
}

class NetworkManager {
    
//    init() {
//        var url: String
//
//    }
    
   static var shared = NetworkManager()
   private var dataTask: URLSessionDataTask?

    
    //escaping use to assync execution
    
    //NOTA : change Error to handler of error enum NetworkManagerError
    func getData(completed: @escaping(Result<[BooksData],Error>) -> Void) {
        
            let urlAPI = "https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0"
        
            guard let url = URL(string:urlAPI ) else {return}
            
            //Create a URL Session - work on the background
            dataTask = URLSession.shared.dataTask(with: url) { (data,response,error) in
                
                //handle error
                if let error = error {
                  print(error)
                }
                
                guard let response = response as? HTTPURLResponse else {
                    //Handle Empty Response
                    print("Empty Response")
                    return
                }
                print("Response status code : \(response.statusCode)")
                
                guard let data = data else {
                    //Handle Empty Data
                    print("Empty Data")
                    return
                }
                
                do {
                    // Parse the data
                    let decoder = JSONDecoder()
                    
                    let jsonData = try
                        decoder.decode([BooksData].self, from: data)
//                    let result = Result(catching: {try decoder.decode([BooksData].self, from: data)})
                    
                    completed(.success(jsonData))
                    
                } catch let error {
                    completed(.failure(error))
                    print(error)
                }
            }
        dataTask?.resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        
            }
}
    



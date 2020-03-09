//
//  ViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 3/9/20.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit


struct PhotoUrls: Codable {
    var raw : String
    var full : String
    var regular : String
    var small : String
    var thumb : String
}
struct Data: Codable{
    var urls : PhotoUrls
}

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        download()
        // Do any additional setup after loading the view.
    }

    
    struct Recipe: Codable{
        var name: String
        var url: URL
        var ingredientsList: [String]
        var instructions: String
    }
    
    func download(){
        print("I'm in download function")
        //get random photo
        let unsplash = "https://api.unsplash.com/photos/random/?client_id=sfuEn6VzVhxMejKp5A3FT9gFvJDX2K4HQ2mp2yFt9OY"
        let unsplash_url = URL(string: unsplash)!
        let config = URLSessionConfiguration.default
        let session = URLSession.shared
        
//        var imgData : [String] = []
        
        let task = session.dataTask(with: unsplash_url) { data, response, error in
            // Check for errors
            guard error == nil else {
                print ("Error: \(error!)")
                return
            }
            // Check that data has been returned
            guard let content = data else {
                print("No data found")
                return
            }
            
            
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let currentImageData = try decoder.decode(Data.self, from: content)
            print(currentImageData.self)
            }
        catch let err { print("Err", err)}
            
        }
    
        task.resume()// execute the HTTP request
    }
}


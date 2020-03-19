//
//  DownloadPhotoListService.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import Foundation

class DownloadPhotoListService{
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    var photos:[Photo] = []
    
    typealias DownloadResult = ([Photo]?, String) -> Void

    func getPhotoList(urlString: String, completion: @escaping DownloadResult){
        dataTask?.cancel()
        
        if var urlComponents = URLComponents(string:urlString){
            guard let url = urlComponents.url else {return}
            dataTask = defaultSession.dataTask(with: url) { [weak self] data, response, error in
                defer {
                    self?.dataTask = nil
                }
                if let error = error {
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                }
                else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    self?.getList(data)
                    DispatchQueue.main.async {
                        completion(self?.photos, self?.errorMessage ?? "")
                    }
                }
                
            }
        }
        dataTask?.resume()
    }
    
    
    func getList(_ jsonData:Data){
        var response: [Any]?
        do{
            response = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [Any]
        }catch let parseError{
            print("JSON Error: \(parseError.localizedDescription)")
            return
        }
        
        guard let array = response else {return}
        
        var index = 0
        for imageDictionary in array{
            if let imageDictionary = imageDictionary as? [String:Any],
                let id = imageDictionary["id"] as? String,
                let author = imageDictionary["author"] as? String,
                let url = imageDictionary["url"] as? URL,
                let download_url = imageDictionary["download_url"] as? URL {
                photos.append(Photo(id: id, author: author, url: url, download_url: download_url, index: index))
                index += 1
            }
            
        }
    }
}


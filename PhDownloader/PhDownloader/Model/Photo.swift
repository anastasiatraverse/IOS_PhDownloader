//
//  Photo.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//
import Foundation
import UIKit

class Photo: NSObject{
    var id:String
    var author:String
    var url:URL
    var download_url: URL
    
    var image: UIImage?
    var isDownloading:Bool = false
    var status:String = "todo"
    
    var index: Int
    var downloaded: Bool = false
    
    init(id:String, author:String, url:URL, download_url:URL, index: Int) {
        self.id = id
        self.author = author
        self.url = url
        self.download_url = download_url
        self.index = index
    }
}
  

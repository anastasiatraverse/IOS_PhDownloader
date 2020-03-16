//
//  Photo.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class Photo: NSObject, Codable{
    var id:String
    var author:String
    var url:String
    var download_url:String
    
    var isDownloading:Bool = false
    
    init(id:String, author:String, url:String, download_url:String) {
        self.id = id
        self.author = author
        self.url = url
        self.download_url = download_url
    }
}

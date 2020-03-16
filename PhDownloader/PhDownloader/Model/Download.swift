//
//  Download.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class Download: NSObject {
    var isDownloading = false
    var progress: Float = 0
    var resume: Data?
    var task: URLSessionDownloadTask?
    var photo: Photo
    
    init(photo: Photo) {
      self.photo = photo
    }
}

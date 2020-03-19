//
//  BaseTabBarViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    var photoList:[Photo] = []
    var inProgressPhotoList:[Photo] = []
    var donePhotoList: [Photo] = []
    
    var downloadService = DownloadService()
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "back")
        return URLSession(configuration: configuration, delegate: self as? URLSessionDelegate, delegateQueue: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadService.downloadSession = downloadsSession
    }
    
}

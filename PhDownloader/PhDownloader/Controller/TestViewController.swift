//
//  TestViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 19.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    var descriptionURL = "https://unsplash.com/photos/U5rMrSI7Pn4"
    var downloadURL = "https://picsum.photos/id/1025/4951/3301"
    var photoList : [Photo] = []
    
    let downloadLists = DownloadPhotoListService()
    let downloadService = DownloadService()
    
    @IBOutlet weak var testImageVW: UIImageView!
    
    lazy var downloadsSession: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "back")
        return URLSession(configuration: configuration, delegate: self as? URLSessionDelegate, delegateQueue: nil)
    }()

    let examplePhoto: Photo = Photo(id: "12345", author: "Traverse", url: "https://unsplash.com/photos/U5rMrSI7Pn4", download_url: "https://picsum.photos/id/1025/4951/3301")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadService.downloadSession = downloadsSession
        downloadService.startDownload(pht: examplePhoto)
    }
    
    @IBAction func pauseBtn(_ sender: Any) {
        downloadService.pauseDownload(pht: examplePhoto)
    }
    
    @IBAction func resumeBtn(_ sender: Any) {
        downloadService.resumeDownload(pht: examplePhoto)
    }
    
    func tableEntry(){
        downloadLists.getPhotoList(urlString: "https://picsum.photos/v2/list?page=1&limit=30"){[weak self] results, errorMessage in
            if let results = results{
                self?.photoList = results
            }
            for i in self!.photoList{
                print(i.url)
                print(i.download_url)
            }
        }
    }
}

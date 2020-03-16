//
//  BaseTabBarViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    let photosPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    var photoList:[Photo] = []
    var inProgressPhotoList:[Photo] = []
    var donePhotoList: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//
//  DisplayPhotoViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class DisplayPhotoViewController: UIViewController {

    let photourl : String = ""
    @IBOutlet weak var photoView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.image = UIImage(contentsOfFile: photourl)
    }
}

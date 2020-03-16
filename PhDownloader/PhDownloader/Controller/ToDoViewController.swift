//
//  ToDoViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class ToDoViewController: UIViewController {

    @IBOutlet weak var toDoTableView: UITableView!
    let downloadLists = DownloadPhotoListService()
    let photoList:[Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

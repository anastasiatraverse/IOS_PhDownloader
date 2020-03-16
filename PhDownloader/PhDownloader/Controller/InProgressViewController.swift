//
//  InProgressViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class InProgressViewController: UIViewController {

    @IBOutlet weak var inProgressTableView: UITableView!
    
    let downloadService = DownloadService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK - Table View
        inProgressTableView.delegate = self
        inProgressTableView.dataSource = self
        inProgressTableView.reloadData()
    }
}

extension InProgressViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let basetab = tabBarController as! BaseTabBarViewController
        return basetab.inProgressPhotoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basetab = tabBarController as! BaseTabBarViewController
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! InProgressTableViewCell
        let photo = basetab.inProgressPhotoList[indexPath.row]
        cell.setCell(pht: photo)
        return cell
    }

}

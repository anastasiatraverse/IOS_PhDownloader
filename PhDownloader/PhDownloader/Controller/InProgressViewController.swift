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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let basetab = tabBarController as! BaseTabBarViewController
        let photo = basetab.inProgressPhotoList[indexPath.row]
        if photo.status == "downloading"{
            photo.status = "paused"
            photo.image = #imageLiteral(resourceName: "play-button")
            downloadService.pauseDownload(pht: photo)}
        else if photo.status == "paused"{
            photo.status = "downloading"
            photo.image = #imageLiteral(resourceName: "pause")
            downloadService.resumeDownload(pht: photo)}
        else{return}
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        print("Deleted")
        let basetab = tabBarController as! BaseTabBarViewController
        downloadService.cancelDownload(pht: basetab.inProgressPhotoList[indexPath.row])
        basetab.inProgressPhotoList.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
      }
    }
}

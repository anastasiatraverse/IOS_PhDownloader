//
//  DoneViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit
import AVKit

class DoneViewController: UIViewController {

    @IBOutlet weak var doneTableView: UITableView!
    
    let photosPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // MARK - table View
        doneTableView.delegate = self
        doneTableView.dataSource = self
        doneTableView.reloadData()
    }
    
    func localFilePath(for url: URL) -> URL {
      return photosPath.appendingPathComponent(url.lastPathComponent)
    }
    
    func openDownloadPhoto(pht: Photo) {
        guard let mainUrl = URL(string: pht.download_url) else{return}
        let photourl = localFilePath(for: mainUrl)
        performSegue(withIdentifier: "segue", sender: photourl)
    }
    
}

extension DoneViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let basetab = tabBarController as! BaseTabBarViewController
        return basetab.donePhotoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basetab = tabBarController as! BaseTabBarViewController
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! DoneTableViewCell
        let photo = basetab.donePhotoList[indexPath.row]
        cell.setCell(pht: photo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("open full picture")
        let basetab = tabBarController as! BaseTabBarViewController
        openDownloadPhoto(pht: basetab.donePhotoList[indexPath.row])
    }
    
    
}

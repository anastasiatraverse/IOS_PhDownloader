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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK - table view delegate and datasource
        toDoTableView.delegate = self
        toDoTableView.dataSource = self
        //Init Table
        tableEntry()
    }
    
    func tableEntry(){
        let basetab = tabBarController as! BaseTabBarViewController
        downloadLists.getPhotoList(urlString: "https://picsum.photos/v2/list?page=1&limit=30"){[weak self] results, errorMessage in
            if let results = results{
                basetab.photoList = results
                self?.getImageByURL()
                self?.toDoTableView.reloadData()
            }
        }
    }
    
    func getImageByURL(){
        let basetab = tabBarController as! BaseTabBarViewController
        for i in basetab.photoList{
            if let mainURL = URL(string: i.download_url){
                guard let data = try? Data(contentsOf: mainURL) else {return}
                i.image = UIImage(data: data) ?? UIImage(contentsOfFile: "ucu.png")!
            }
        }
    }
}

extension ToDoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let basetab = tabBarController as! BaseTabBarViewController
        return basetab.photoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basetab = tabBarController as! BaseTabBarViewController
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell") as! ToDoTableViewCell
        let photo = basetab.photoList[indexPath.row]
        cell.setCell(pht: photo)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let basetab = tabBarController as! BaseTabBarViewController
        basetab.photoList[indexPath.row].status = "downloading"
        basetab.inProgressPhotoList.append(basetab.photoList[indexPath.row])
        basetab.photoList.remove(at: indexPath.row)
        toDoTableView.reloadData()
    }
    
}

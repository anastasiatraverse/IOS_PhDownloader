//
//  DoneViewController.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class DoneViewController: UIViewController {

    @IBOutlet weak var doneTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        // MARK - table View
        doneTableView.delegate = self
        doneTableView.dataSource = self
        doneTableView.reloadData()
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
    
    
}

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
    
    let photosPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK - Table View
        inProgressTableView.delegate = self
        inProgressTableView.dataSource = self
        inProgressTableView.reloadData()
    }
    
    func localFilePath(for url: URL) -> URL {
      return photosPath.appendingPathComponent(url.lastPathComponent)
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

//
// MARK: - URL Session Download Delegate
//

extension InProgressViewController: URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let sourceURL = downloadTask.originalRequest?.url else{return}
        let download = downloadService.active[sourceURL]
        downloadService.active[sourceURL] = nil
        
        let destinationURL = localFilePath(for: sourceURL)
        print(destinationURL)
        
        let fileManager = FileManager.default
        try? fileManager.removeItem(at: destinationURL)
        
        do{
            try fileManager.copyItem(at: location, to: destinationURL)
            download?.photo.downloaded = true
        }catch let error {
          print("Could not copy file to disk: \(error.localizedDescription)")
        }
        
        if let index = download?.photo.index {
            DispatchQueue.main.async{ [weak self] in
                self?.inProgressTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        guard let url = downloadTask.originalRequest?.url, let download = downloadService.active[url]
            else {return}
        
        download.progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
       
        //TO DO: - DispatchQueue Main Async update progress
        DispatchQueue.main.async {
            if let photoCell = self.inProgressTableView.cellForRow(at: IndexPath(row: download.photo.index,section: 0)) as? InProgressTableViewCell{
                photoCell.updateCell(progress: download.progress, size: totalSize)
            }
        }
    }
    
}

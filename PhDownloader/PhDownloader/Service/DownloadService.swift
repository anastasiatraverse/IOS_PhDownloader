//
//  DownloadService.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import Foundation

class DownloadService{
    var active :[URL: Download] = [:]
    var downloadSession: URLSession!

    func startDownload(pht: Photo){
        let download = Download(photo:pht)
        download.task = downloadSession.downloadTask(with: pht.download_url)
        download.task?.resume()
        download.isDownloading = true
        active[pht.download_url] = download
        print("Download Start")
    }
    
    func cancelDownload(pht: Photo){
        guard let download = active[pht.download_url] else{return}
        download.task?.cancel()
        active[pht.download_url] = nil
        print("Download Cancel")
    }
    
    func pauseDownload(pht: Photo){
        guard let download = active[pht.download_url] else{return}
        download.task?.cancel(byProducingResumeData: {
            data in download.resume = data
        })
        download.isDownloading = false
        print("Download Pause")
    }
    
    func resumeDownload(pht: Photo){
        guard let download = active[pht.url] else{return}
        if let resume = download.resume {
            download.task = downloadSession.downloadTask(withResumeData: resume)
        }else{
            download.task = downloadSession.downloadTask(with: pht.download_url)
        }
        print("Download Resume")
    }
}

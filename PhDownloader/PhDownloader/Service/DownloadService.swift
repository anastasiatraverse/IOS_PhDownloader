//
//  DownloadService.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import Foundation

class DownloadService{
    var active :[String: Download] = [:]
    var downloadSession: URLSession!

    func startDownload(pht: Photo){
        let download = Download(photo:pht)
        guard let url = URL(string: pht.url) else {return}
        download.task = downloadSession.downloadTask(with: url)
        download.task?.resume()
        download.isDownloading = true
        active[pht.url] = download
    }
    
    func cancelDownload(pht: Photo){
        guard let download = active[pht.url] else{return}
        download.task?.cancel()
        active[pht.url] = nil
    }
    
    func pauseDownload(pht: Photo){
        guard let download = active[pht.url] else{return}
        download.task?.cancel(byProducingResumeData: {
            data in download.resume = data
        })
        download.isDownloading = false
    }
    
    func resumeDownload(pht: Photo){
        guard let download = active[pht.url] else{return}
        if let resume = download.resume {
            download.task = downloadSession.downloadTask(withResumeData: resume)
        }else{
            guard let url = URL(string: pht.url) else {return}
            download.task = downloadSession.downloadTask(with: url)
        }
    }
}

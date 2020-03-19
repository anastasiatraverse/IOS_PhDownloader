//
//  InProgressTableViewCell.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class InProgressTableViewCell: UITableViewCell {

    @IBOutlet weak var inProgressImageVW: UIImageView!
    @IBOutlet weak var authorLB: UILabel!
    @IBOutlet weak var progressLB: UILabel!
    @IBOutlet weak var progressVW: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(pht: Photo){
        inProgressImageVW.image = pht.image
        authorLB.text = pht.author
    }
    
    func updateCell(progress: Float, size: String){
        progressVW.progress = progress
        progressLB.text = String(format: "%.1f%% / %@",  progress * 100, size)
    }
}

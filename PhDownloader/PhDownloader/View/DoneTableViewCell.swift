//
//  DoneTableViewCell.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class DoneTableViewCell: UITableViewCell {

    @IBOutlet weak var doneImageVW: UIImageView!
    @IBOutlet weak var authorLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCell(pht: Photo){
        doneImageVW.image = pht.image
        authorLB.text = pht.author
    }
}

//
//  InProgressTableViewCell.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе on 16.03.2020.
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

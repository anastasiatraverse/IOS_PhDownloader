//
//  ToDoTableViewCell.swift
//  PhDownloader
//
//  Created by Анастасия Траверсе.
//  Copyright © 2020 Анастасия Траверсе. All rights reserved.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageCellVM: UIImageView!
    @IBOutlet weak var authorLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(pht: Photo){
        imageCellVM.image = pht.image
        authorLB.text = pht.author
    }
    
   
}

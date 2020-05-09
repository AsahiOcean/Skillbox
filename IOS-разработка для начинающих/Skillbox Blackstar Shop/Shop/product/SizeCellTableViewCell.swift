//
//  SizeCellTableViewCell.swift
//  Shop
//
//  Created by Serg Fedotov on 01.05.2020.
//  Copyright © 2020 Sergey Fedotov. All rights reserved.
//

import UIKit

class SizeCellTableViewCell: UITableViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

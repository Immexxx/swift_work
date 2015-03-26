//
//  customCellTableViewCell.swift
//  WherePedia
//
//  Created by yeshaokai on 3/12/15.
//  Copyright (c) 2015 yeshaokai. All rights reserved.
//

import UIKit

class customCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myimageView: UIImageView!
  
    @IBOutlet weak var mytextLabel: UILabel!
    
    @IBOutlet weak var mylocationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

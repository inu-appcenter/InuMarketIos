//
//  PreImageViewTableViewCell.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 12..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow

class PreImageViewTableViewCell: UITableViewCell {

    @IBOutlet weak var slideshow: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

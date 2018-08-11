//
//  PreExplainViewTableViewCell.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 12..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class PreExplainViewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var explainLabel: UITextView!
    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var methodLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

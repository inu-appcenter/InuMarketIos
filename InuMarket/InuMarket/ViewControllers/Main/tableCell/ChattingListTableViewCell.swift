//
//  ChattingListTableViewCell.swift
//  InuMarket
//
//  Created by 김성은 on 11/02/2019.
//  Copyright © 2019 동균. All rights reserved.
//

import UIKit

class ChattingListTableViewCell: UITableViewCell {
    
    @IBOutlet var chattingNameLabel: UILabel!
    @IBOutlet var chattingMessageLabel: UILabel!
    @IBOutlet var chattingDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

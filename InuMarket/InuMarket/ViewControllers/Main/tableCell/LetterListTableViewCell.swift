//
//  LetterListTableViewCell.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 16..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ExpandableCell

class LetterListTableViewCell: ExpandableCell {
    
    static let ID = "LetterListTableViewCell"
    
    @IBOutlet var letterImg: UIImageView!
    @IBOutlet var letterTitle: UILabel!
    @IBOutlet weak var endTitle: UILabel!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    
}

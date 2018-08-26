//
//  CategoryDetailTableViewCell.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 24..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ExpandableCell

class CategoryDetailTableViewCell: UITableViewCell {

    static let ID = "CategoryDetailTableViewCell"
    
    @IBOutlet var detailLabel: UILabel!
    
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

//
//  LetterContentTableViewCell.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 16..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ExpandableCell

class LetterContentTableViewCell: UITableViewCell {
    
    static let ID = "LetterContentTableViewCell"

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var phoneNumLabel: UILabel!
    @IBOutlet var buttonStackView: UIStackView!
    @IBOutlet var contactButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        buttonStackView.layer.addBorder([.top], color: #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9607843137, alpha: 1), width: 1)
        cancelButton.layer.addBorder([.left], color: #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9607843137, alpha: 1), width: 1)
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
}

//
//  MainHeaderCollectionViewCell.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 6..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class MainHeaderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var headerTitle: UILabel!
    
    var sortButton: VKExpandableButton!
    
    let screenWidth = UIScreen.main.bounds.width
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        createSortButton()
//        self.contentView.addSubview(sortButton)
        
        self.sortButton.optionSelectionBlock = {
            index in
            print("[Left] Did select cat at index: \(index)")
        }
    }
    
    func createSortButton() {
        sortButton = VKExpandableButton(frame: CGRect(x: screenWidth - 102, y: 150, width: 92, height: 36))
        sortButton.direction = .Down
        sortButton.options = ["최신 상품순", "높은 가격순", "낮은 가격순"]
        sortButton.currentValue = sortButton.options[0]
        
        sortButton.textColor = UIColor(red: 241/255, green: 109/255, blue: 103/255, alpha: 1)
        sortButton.buttonBackgroundColor = UIColor.white
        sortButton.expandedTextColor = UIColor(red: 51/255, green: 58/255, blue: 65/255, alpha: 1)
        sortButton.expandedButtonBackgroundColor = UIColor.white
        sortButton.selectionColor = UIColor(red: 232/255, green: 231/255, blue: 231/255, alpha: 1)
        
        sortButton.cornerRadius = 8
        sortButton.layer.shadowColor = UIColor.black.cgColor
        sortButton.layer.shadowOpacity = 0.25
        sortButton.layer.masksToBounds = false
        sortButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    func createSearchSortButton() {
        sortButton = VKExpandableButton(frame: CGRect(x: screenWidth - 102, y: 18, width: 92, height: 36))
        sortButton.direction = .Down
        sortButton.options = ["최신 상품순", "높은 가격순", "낮은 가격순"]
        sortButton.currentValue = sortButton.options[0]
        
        sortButton.textColor = UIColor(red: 241/255, green: 109/255, blue: 103/255, alpha: 1)
        sortButton.buttonBackgroundColor = UIColor.white
        sortButton.expandedTextColor = UIColor(red: 51/255, green: 58/255, blue: 65/255, alpha: 1)
        sortButton.expandedButtonBackgroundColor = UIColor.white
        sortButton.selectionColor = UIColor(red: 232/255, green: 231/255, blue: 231/255, alpha: 1)
        
        sortButton.cornerRadius = 8
        sortButton.layer.shadowColor = UIColor.black.cgColor
        sortButton.layer.shadowOpacity = 0.25
        sortButton.layer.masksToBounds = false
        sortButton.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
}

extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}

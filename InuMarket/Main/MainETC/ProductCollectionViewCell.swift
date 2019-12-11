//
//  ProductCollectionViewCell.swift
//  InuMarket
//
//  Created by 김성은 on 04/12/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var subCategoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 11
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        
        productImageView.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
        productImageView.layer.cornerRadius = 7
        subCategoryLabel.font = UIFont.NotoSansCJKKr(type: .regular, size: 9)
        nameLabel.font = UIFont.NotoSansCJKKr(type: .regular, size: 10)
        priceLabel.font = UIFont.NotoSansCJKKr(type: .bold, size: 10)
    }
    
    var label: UILabel! = {
        let label = UILabel()
        return label
    }()
    
    override func prepareForReuse() {
        label.text = nil
    }
    
    func setText(text: String) {
        
        /*self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15)
        
        self.label.text = text*/
        
        
    }
}

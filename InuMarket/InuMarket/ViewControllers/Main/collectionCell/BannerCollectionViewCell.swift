//
//  BannerCollectionViewCell.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var bannerView: ImageSlideshow!
    
    override func awakeFromNib() {
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BannerCollectionViewCell.didTap))
        bannerView.addGestureRecognizer(gestureRecognizer)
    }
    @objc func didTap() {
        
        switch bannerView.currentPage {
            
        case 0:
            print(0)
            UIApplication.shared.openURL(URL(string: "https://itunes.apple.com/kr/app/inu-%EC%B9%B4%ED%8E%98%ED%85%8C%EB%A6%AC%EC%95%84/id1272600111?mt=8")!)
//            UIApplication.shared.openURL(URL(string: "sample://itunes.apple.com/kr/app/inu-%EC%B9%B4%ED%8E%98%ED%85%8C%EB%A6%AC%EC%95%84/id1272600111?mt=8")!)
        case 1:
            print(1)
            UIApplication.shared.openURL(URL(string: "sample://itunes.apple.com/kr/app/%EC%9D%B8%EC%B2%9C%EB%8C%80-%EB%8F%99%EC%95%84%EB%A6%AC/id1360625693?mt=8")!)
        case 2:
            print(2)
            UIApplication.shared.openURL(URL(string: "https://itunes.apple.com/kr/app/%EA%B8%88%EC%97%B0%EC%9D%98-%EB%AF%BC%EC%A1%B1/id1356023968?mt=8")!)
        default:
            print(000)
        }

    }
}

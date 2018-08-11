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
        slideshow.backgroundColor = UIColor.white
        slideshow.slideshowInterval = 3.0
        slideshow.pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        slideshow.pageControl.pageIndicatorTintColor = UIColor.black
        slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BannerCollectionViewCell.didTap))
        slideshow.addGestureRecognizer(gestureRecognizer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Upload", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "UploadPreView") as? MainViewController else {
            return
        }
        let fullScreenController = slideshow.presentFullScreenController(from: vc)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }

    
    
  

}

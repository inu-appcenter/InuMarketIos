//
//  DetailViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow

class DetailViewController: UIViewController {

    //MARK: properties
    let headerIdentifier: String = "DetailHeaderCollectionViewCell"
    let cellIdentifier: String = "DetailCollectionViewCell"
    let footerIdentifier: String = "DetailFooterCollectionViewCell"
    
    let screenWidth = UIScreen.main.bounds.width
    
    var gesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    //MARK: IBOutlet
    @IBOutlet weak var productImgView: ImageSlideshow!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var sendLetterView: UIView!
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        sendLetterView.addGestureRecognizer(gesture)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(productImgTapped))
        productImgView.addGestureRecognizer(gestureRecognizer)
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.white
        pageIndicator.pageIndicatorTintColor = #colorLiteral(red: 0.4779999852, green: 0.4779999852, blue: 0.4779999852, alpha: 1)
        productImgView.pageIndicator = pageIndicator
        productImgView.setImageInputs([ImageSource(image: UIImage(named: "rectangle4Copy")!),
                                       ImageSource(image: UIImage(named: "rectangle4Copy")!),
                                       ImageSource(image: UIImage(named: "rectangle4Copy")!),
                                       ImageSource(image: UIImage(named: "rectangle4Copy")!)])
    }
    
    //MARK: Methods
    @objc func productImgTapped() {
        let fullScreenController = productImgView.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }
    
    @objc private func viewTapped(_ sender: UITapGestureRecognizer) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let sendLetterVC = storyboard.instantiateViewController(withIdentifier: "sendLetter") as? SendLetterViewController else { return }
//        sendLetterVC.modalPresentationStyle = .overCurrentContext
        self.present(sendLetterVC, animated: true, completion: nil)
    }

}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            guard let cell: DetailHeaderCollectionViewCell = detailCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath) as? DetailHeaderCollectionViewCell else { return UICollectionReusableView() }
            cell.nameLabel.text = "전동자전거"
            cell.priceLabel.text = "250,000원"
            cell.inquiryLabel.text = "현재 12명의 학생들이 문의중입니다!"
            cell.declareButton.setImage(UIImage(named: "declare"), for: .normal)
            return cell
            
        case UICollectionElementKindSectionFooter:
            guard let cell: DetailFooterCollectionViewCell = detailCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier, for: indexPath) as? DetailFooterCollectionViewCell else { return UICollectionReusableView() }
            cell.showProductButton.setImage(UIImage(named: "showOtherProduct"), for: .normal)
            return cell
        default: return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 121)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: 166)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: DetailCollectionViewCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
        cell.explainTextView.text = """
        여러가지 설명
        설명
        """
        cell.stateLabel.text = "- 상품 상태 : 중고 4개월 탐"
        cell.transMethodLabel.text = "- 거래 방식 : 직거래"
        cell.transPlaceLabel.text = "- 거래 장소 : 16호관"
        cell.categoryLabel.text = "- 카테고리 : 가전 / 가구 - 기타"
        return cell
    }
    
}

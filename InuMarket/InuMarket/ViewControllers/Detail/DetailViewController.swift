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
    
    var productId: String?
    var model : NetworkModel?
    var detailList: detailProduct?{
        didSet {
            if self.detailCollectionView != nil {
                self.detailCollectionView.reloadData()
            }
        }
    }
    
    var price2Int: Int?
    var star2Int: Int?
    var state2String: String?
    var method2String: String?
    var place2String: String?
    var category2String: String?

    
    //MARK: IBOutlet
    @IBOutlet weak var productImgView: ImageSlideshow!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var sendLetterView: UIView!
    
    //MARK: life cycle
    override func viewWillAppear(_ animated: Bool) {
        model = NetworkModel(self)
        model?.detailProduct(productId: productId!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        gesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        sendLetterView.addGestureRecognizer(gesture)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(productImgTapped))
        productImgView.addGestureRecognizer(gestureRecognizer)
        productImgView.slideshowInterval = 2.0


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
            cell.nameLabel.text = self.detailList?.productName
            cell.priceLabel.text = "\(detailList?.productPrice)"
            cell.inquiryLabel.text = "현재 \(detailList?.productStar)명의 학생들이 문의중입니다!"
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
        cell.explainTextView.text = self.detailList?.productInfo
        cell.stateLabel.text = "- 상품 상태 : \(detailList?.productState)"
        cell.transMethodLabel.text = "- 거래 방식 : \(detailList?.method)"
        cell.transPlaceLabel.text = "- 거래 장소 : \(detailList?.place)"
        cell.categoryLabel.text = "- 카테고리 : \(detailList?.category)"
        if detailList?.method == "택배"{
            cell.transPlaceLabel.text = "- 거래 장소 : 택배"
        }
        return cell
    }
    
}

extension DetailViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "detailSuccess"{
            print(resultdata)
            var temp: [detailProduct] = []
            if let items = resultdata as? NSDictionary {
                let productId = items["productId"] as? String ?? ""
                let productName = items["productName"] as? String ?? ""
                let category = items["category"] as? String ?? ""
                let updateDate = items["updateDate"] as? String ?? ""
                let productPrice = items["productPrice"] as? Int ?? 0
                let productSelled = items["productSelled"] as? Bool ?? false
                let productImg = items["productImg"] as? [String] ?? [""]
                let productState = items["productState"] as? String ?? ""
                let productStar = items["productStar"] as? Int ?? 0
                let productInfo = items["productInfo"] as? String ?? ""
                let method = items["method"] as? String ?? ""
                let place = items["place"] as? String ?? ""
                let sellerId = items["sellerId"] as? String ?? ""
                let obj = detailProduct.init(productImg: productImg, productId: productId, productName: productName, productState: productState, productStar: productStar, productPrice: productPrice, productSelled: productSelled, category: category, productInfo: productInfo, method: method, place: place, sellerId: sellerId, updateDate: updateDate)
                temp.append(obj)
                detailList = obj
            }
        }
    }
    func networkFail(code: String) {
        if code == "detailError"{
        print("error")
    }
    }
}

//
//  DetailViewController.swift
//  InuMarket
//
//  Created by 김재희 on 2018. 8. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow
import Kingfisher
import Toast_Swift

class DetailViewController: UIViewController {
    
    //MARK: properties
    let headerIdentifier: String = "DetailHeaderCollectionViewCell"
    let cellIdentifier: String = "DetailCollectionViewCell"
    let footerIdentifier: String = "DetailFooterCollectionViewCell"
    
    let screenWidth = UIScreen.main.bounds.width
    
    var gesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    var productId: String?
    var model : NetworkModel?
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var detailList: detailProduct?{
        didSet {
            if self.detailCollectionView != nil {
                imageDownload()
                self.detailCollectionView.reloadData()
            }
        }
    }
    var imageCount: Int?
    var priceProduct : Int = 0
    var starProduct : Int = 0
    var stateProduct : String = ""
    var methodProduct : String = ""
    var placeProduct: String = ""
    var categoryProduct: String = ""
    
    
    var productImg: [KingfisherSource] = []
    
    //MARK: IBOutlet
    @IBOutlet weak var productImgView: ImageSlideshow!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var sendLetterView: UIView!
    
    //MARK: life cycle
    override func viewWillAppear(_ animated: Bool) {
//        model = NetworkModel(self)
//        model?.detailProduct(productId: productId!)
        self.navigationController?.navigationBar.backItem?.title = ""

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.makeToastActivity(.center)
        model = NetworkModel(self)
        model?.detailProduct(productId: productId!)
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
    func imageDownload(){
        for i in 0..<imageCount!{
            self.productImg.append(KingfisherSource(url:URL(string:"\(self.appDelegate.serverURL)imgload/\(detailList!.productImg![i])")!))
        }
        productImgView.setImageInputs(self.productImg)
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
        sendLetterVC.productImageSlide = productImg
        sendLetterVC.productName = (self.detailList?.productName)!
        sendLetterVC.sellerId = (self.detailList?.sellerId)!
        sendLetterVC.productId = (self.detailList?.productId)!
        sendLetterVC.category = (self.detailList?.category)!
        self.present(sendLetterVC, animated: true, completion: nil)
    }
    
    @objc private func showOtherProduct(_ sender: UITapGestureRecognizer) {
        print("showOtherProduct")
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let otherProductVC = storyboard.instantiateViewController(withIdentifier: "otherProduct") as? OtherProductViewController else {return}
        otherProductVC.sellerId = detailList?.sellerId
        self.navigationController?.show(otherProductVC, sender: nil)
    }
    
    @objc private func showDeclare(_ sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "신고하기", message: "신고 이유를 선택해주세요.", preferredStyle: .alert)
        let 음란성 = UIAlertAction(title: "음란성", style: .default) {
            (_) in
            self.model?.banReport(kind: "음란성", senderId: self.appDelegate.userInfo!.id!, productId: self.productId!)
            self.상품신고완료()
            return
        }
        let 도배 = UIAlertAction(title: "도배", style: .default) {
            (_) in
            self.model?.banReport(kind: "도배", senderId: self.appDelegate.userInfo!.id!, productId: self.productId!)
            self.상품신고완료()
            return
        }
        let 광고 = UIAlertAction(title: "광고", style: .default) {
            (_) in
            self.model?.banReport(kind: "광고", senderId: self.appDelegate.userInfo!.id!, productId: self.productId!)
            self.상품신고완료()
            return
        }
        let 허위상품 = UIAlertAction(title: "허위 상품", style: .default) {
            (_) in
            self.model?.banReport(kind: "허위상품", senderId: self.appDelegate.userInfo!.id!, productId: self.productId!)
            self.상품신고완료()
            return
        }
        let 취소 = UIAlertAction(title: "취소", style: .cancel) {
            (_) in
            return
        }
        
        alert.addAction(음란성)
        alert.addAction(도배)
        alert.addAction(광고)
        alert.addAction(허위상품)
        alert.addAction(취소)
        self.present(alert, animated: true)
    }
    
    private func 상품신고완료() {
        
        let alert2 = UIAlertController(title: "상품 신고가 완료되었습니다.", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) {
            (_) in
            return
        }
        alert2.addAction(ok)
        self.present(alert2, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let nextVC: OtherProductViewController = segue.destination as? OtherProductViewController else { return }
//        guard let cell: DetailHeaderCollectionViewCell = sender as? DetailHeaderCollectionViewCell else { return }
//        nextVC.productName = cell.nameLabel?.text
//    }
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
            cell.priceLabel.text = "\(priceProduct) 원"
            cell.inquiryLabel.text = "현재 \(starProduct)명의 학생들이 문의중입니다!"
            
            cell.declareButton.setImage(UIImage(named: "declare"), for: .normal)
            cell.declareButton.addTarget(self, action: #selector(showDeclare(_:)), for: .touchUpInside)
            cell.declareButton.isUserInteractionEnabled = true
            cell.bringSubview(toFront: cell.declareButton)
            return cell
            
        case UICollectionElementKindSectionFooter:
            guard let cell: DetailFooterCollectionViewCell = detailCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footerIdentifier, for: indexPath) as? DetailFooterCollectionViewCell else { return UICollectionReusableView() }
            
            cell.showProductButton.setImage(UIImage(named: "showOtherProduct"), for: .normal)
            cell.showProductButton.addTarget(self, action: #selector(showOtherProduct(_:)), for: .touchUpInside)
            cell.showProductButton.isUserInteractionEnabled = true
            cell.bringSubview(toFront: cell.showProductButton)
            return cell
        default: return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 121)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: 166)
//        return UICollectionViewFlowLayoutAutomaticSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth, height: 52)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: DetailCollectionViewCell = detailCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? DetailCollectionViewCell else { return UICollectionViewCell() }
        cell.explainTextView.text = self.detailList?.productInfo
        cell.stateLabel.text = "- 상품 상태 : \(stateProduct)"
        cell.transMethodLabel.text = "- 거래 방식 : \(methodProduct)"
        cell.transPlaceLabel.text = "- 거래 장소 : \(placeProduct)"
        cell.categoryLabel.text = "- 카테고리 : \(categoryProduct)"
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
                let sellerName = items["sellerName"] as? String ?? ""
                let sellerPhone = items["sellerPhone"] as? String ?? ""
                let obj = detailProduct.init(productImg: productImg, productId: productId, productName: productName, productState: productState, productStar: productStar, productPrice: productPrice, productSelled: productSelled, category: category, productInfo: productInfo, method: method, place: place, sellerId: sellerId, updateDate: updateDate, sellerName: sellerName, sellerPhone: sellerPhone)
                temp.append(obj)
                imageCount = obj.productImg?.count
                priceProduct = obj.productPrice!
                starProduct = obj.productStar!
                methodProduct = obj.method!
                placeProduct = obj.place!
                categoryProduct = obj.category!
                stateProduct = obj.productState!
                detailList = obj
                self.appDelegate.detailList = obj
                
            }
            self.view.hideToastActivity()
        }else if code == "reportSuccess" {
            print(resultdata)
            
            if let item = resultdata as? NSDictionary {
                let ans = item["ans"] as? Bool ?? false
                let obj = AnsResult.init(ans: ans)
//                self.ansResult = obj
            }
            상품신고완료()
        }
    }
    func networkFail(code: String) {
        if code == "detailError"{
            print("error")
        }else if code == "reportError"{
            print("error")
        }
    }
}
 

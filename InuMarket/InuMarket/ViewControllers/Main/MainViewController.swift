//
//  MainViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import ImageSlideshow
import SnapKit
import Kingfisher

class MainViewController: UIViewController {
    
    //MARK: properties
    let bannerCellIdentifier: String = "BannerCollectionViewCell"
    let letterCellIdentifier: String = "LetterCollectionViewCell"
    let headerCellIdentifier: String = "MainHeaderCollectionViewCell"
    let mainCellIdentifier: String = "MainCollectionViewCell"
    
    let detailIdentifier: String = "detailView"
    
    let screenWidth = UIScreen.main.bounds.width
    
    var textFieldActive: Bool = false
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var model : NetworkModel?
    var productList: [AllProduct] = []{
        didSet {
            if self.productCollectionView != nil {
                self.productCollectionView.reloadData()
            }
        }
    }
    var detailProductList: [detailProduct] = []
    
    
    private var cancelButton: UIButton = {
        let button: UIButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 70, y: 75, width: 61, height: 48))
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor(red: 71/255, green: 80/255, blue: 88/255, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: IBOutlet
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK: IBActiion
    @IBAction func leftButtonDidPressed(_ sender: Any) {
        
    }
    
    @IBAction func rightButtonDidPressed(_ sender: Any) {
        
    }
    
    @IBAction func viewDidTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        model = NetworkModel(self)
        model?.allProduct()
        
        initializing()
        
        let time = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.productCollectionView.reloadData()
        }
        // Do any additional setup after loading the view.
        searchTextField.addTarget(self, action: #selector(textFieldDidChange),
                                  for: UIControlEvents.editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchTextField.delegate = self
    }
    
    //MARK: Methods
    @objc func cancelButtonTapped(sender: UIButton!) {
        cancelButton.removeFromSuperview()
        textFieldActive = false
        searchTextField.text = ""
        searchTextField.resignFirstResponder()
        productCollectionView.isHidden = false
        productCollectionView.reloadData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if searchTextField.hasText {
            productCollectionView.isHidden = false
            productCollectionView.reloadData()
        } else {
            productCollectionView.isHidden = true
            productCollectionView.reloadData()
        }
        
    }
    
    func showDetailVC() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(withIdentifier: detailIdentifier) as? DetailViewController else { return }
        self.navigationController?.show(detailVC, sender: nil)
    }
    
    func initializing() {
        // navigation initializing
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        let mainlogo = UIImage(named: "mainLogo.png")
        let imageview = UIImageView(image: mainlogo)
        self.navigationItem.titleView = imageview
        
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    //MARK: UITextField Methods
    func textFieldDidBeginEditing(_ textField: UITextField) { //텍스트필드 입력이 시작 됐을 때
        textFieldActive = true
        productCollectionView.isHidden = true
        
        self.view.addSubview(cancelButton)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    
    //MARK: UICollectionView Methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if textFieldActive {
            return 1
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if textFieldActive {
            return 20
        } else {
            switch section {
            case 0: return 1
            case 1: return 1
            case 2: return productList.count
            default: return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell: MainHeaderCollectionViewCell = self.productCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerCellIdentifier, for: indexPath) as? MainHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        //정렬 버튼 추가
        if textFieldActive {
            cell.sortButton.removeFromSuperview()
            
            cell.createSearchSortButton()
            productCollectionView.addSubview(cell.sortButton)
        } else {
            cell.sortButton.removeFromSuperview()
            
            cell.createSortButton()
            productCollectionView.addSubview(cell.sortButton)
        }
        if textFieldActive {
            if searchTextField.hasText {
                cell.headerTitle?.text = "'\(searchTextField.text ?? "")'에 대한 검색 결과"
            }
        } else{
            cell.headerTitle?.text = "실시간 상품"
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if textFieldActive {
            showDetailVC()
        } else {
            switch indexPath.section {
            case 0:
                guard let cell: BannerCollectionViewCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: bannerCellIdentifier, for: indexPath) as? BannerCollectionViewCell else { return }
                let fullScreenController = cell.bannerView.presentFullScreenController(from: self)
                fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
                
            case 1:
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                guard let letterBoxVC = storyboard.instantiateViewController(withIdentifier: "letterBox") as? LetterBoxViewController else { return }
                self.navigationController?.show(letterBoxVC, sender: nil)
            case 2:
//                showDetailVC()
                let storyboard: UIStoryboard = UIStoryboard(name: "Detail", bundle: nil)
                guard let detailVC = storyboard.instantiateViewController(withIdentifier: detailIdentifier) as? DetailViewController else { return }
                detailVC.productId = productList[indexPath.row].productId
                model?.detailProduct(productId: detailVC.productId!)
//                detailVC.detailList = self.detailProductList
                
                let time = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: time) {
//                    detailVC.detailList = self.detailProductList
                    self.navigationController?.show(detailVC, sender: nil)

                }
//                self.navigationController?.show(detailVC, sender: nil)
                
                
            default: return
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if textFieldActive {
            return CGSize(width: screenWidth, height: 80)
        } else {
            switch section {
            case 2: return CGSize(width: screenWidth, height: 80)
            default: return CGSize(width: 0, height: 0)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if textFieldActive {
            return CGSize(width: 100, height: 140)
        } else {
            switch indexPath.section {
            case 0: return CGSize(width: screenWidth, height: 80)
            case 1: return CGSize(width: screenWidth, height: 52)
            case 2: return CGSize(width: 100, height: 140)
            default: return CGSize(width: 0, height: 0)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if textFieldActive {
            guard let cell: MainCollectionViewCell = productCollectionView.dequeueReusableCell(withReuseIdentifier: mainCellIdentifier, for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            let logo = "\(self.appDelegate.serverURL)imgload/\(productList[indexPath.row].productImg![0])"
            let resource = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
            cell.productImg.kf.setImage(with: resource)
            cell.productName.text = productList[indexPath.row].productName
            cell.productPrice.text = String(productList[indexPath.row].productPrice!)
            return cell
            
        } else {
            switch indexPath.section {
            case 0:
                guard let cell: BannerCollectionViewCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: bannerCellIdentifier, for: indexPath) as? BannerCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let pageIndicator = UIPageControl()
                pageIndicator.currentPageIndicatorTintColor = UIColor.white
                pageIndicator.pageIndicatorTintColor = #colorLiteral(red: 0.4779999852, green: 0.4779999852, blue: 0.4779999852, alpha: 1)
                cell.bannerView.pageIndicator = pageIndicator
                cell.bannerView.setImageInputs([ImageSource(image: UIImage(named: "promotionsAppcenter")!),
                                                ImageSource(image: UIImage(named: "promotionsAppcenter")!)])
                return cell
            case 1:
                guard let cell: LetterCollectionViewCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: letterCellIdentifier, for: indexPath) as? LetterCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.letterImg.image = UIImage(named: "letterRead")
                cell.letterBoxLabel.text = "나의 쪽지함"
                cell.letterNum.text = "0"
                cell.rightImg.image = UIImage(named: "rightside")
                return cell
            case 2:
                guard let cell: MainCollectionViewCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: self.mainCellIdentifier, for: indexPath) as? MainCollectionViewCell else {
                    return UICollectionViewCell()
                }
                let logo = "\(self.appDelegate.serverURL)imgload/\(productList[indexPath.row].productImg![0])"
                let resource = ImageResource(downloadURL: URL(string: logo)!, cacheKey: logo)
                cell.productImg.kf.setImage(with: resource)
                cell.productName.text = productList[indexPath.row].productName
                cell.productPrice.text = String(productList[indexPath.row].productPrice!)
                
                return cell
                
                
            default: return UICollectionViewCell()
                
            }
        }
    }
    
}

extension MainViewController: NetworkCallback{
    func networkSuc(resultdata: Any, code: String) {
        if code == "allProductSuccess" {
            print(resultdata)
            
            var temp: [AllProduct] = []
            if let items = resultdata as? [NSDictionary] {
                for item in items {
                    let productId = item["productId"] as? String ?? ""
                    let productName = item["productName"] as? String ?? ""
                    let category = item["category"] as? String ?? ""
                    let updateDate = item["updateDate"] as? String ?? ""
                    let productPrice = item["productPrice"] as? Int ?? 0
                    let productSelled = item["productSelled"] as? Bool ?? false
                    let productImg = item["productImg"] as? [String] ?? [""]
                    let obj = AllProduct.init(productImg: productImg, productId: productId, productName: productName, productPrice: productPrice, productSelled: productSelled, category: category, updateDate: updateDate)
                    temp.append(obj)
                    
                    
                }
            }
            productList = temp
        }
    }
    
    
    func networkFail(code: String) {
        if(code == "allProductError") {
            print("실패하였습니다.")
        }
    }
    
    
}

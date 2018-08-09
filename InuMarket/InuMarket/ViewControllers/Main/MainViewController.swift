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

class MainViewController: UIViewController {
    
    //MARK: properties
    let bannerCellIdentifier: String = "BannerCollectionViewCell"
    let letterCellIdentifier: String = "LetterCollectionViewCell"
    let headerCellIdentifier: String = "MainHeaderCollectionViewCell"
    let mainCellIdentifier: String = "MainCollectionViewCell"
    
    let detailIdentifier: String = "detailView"
    
    let screenWidth = UIScreen.main.bounds.width
    
    var textFieldActive: Bool = false
    
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
        
        initializing()
        
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
            case 2: return 20
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
            case 1:
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                guard let letterBoxVC = storyboard.instantiateViewController(withIdentifier: "letterBox") as? LetterBoxViewController else { return }
                self.navigationController?.show(letterBoxVC, sender: nil)
            case 2: showDetailVC()
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
            cell.productImg.image = UIImage(named: "rectangle4Copy")
            cell.productName.text = "상품 이름"
            cell.productPrice.text = "250,000원"
            return cell
            
        } else {
            switch indexPath.section {
            case 0:
                guard let cell: BannerCollectionViewCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: bannerCellIdentifier, for: indexPath) as? BannerCollectionViewCell else {
                    return UICollectionViewCell()
                }
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
                cell.productImg.image = UIImage(named: "rectangle4Copy")
                cell.productName.text = "상품 이름"
                cell.productPrice.text = "250,000원"
                return cell
                
            default: return UICollectionViewCell()
                
            }
        }
    }

}



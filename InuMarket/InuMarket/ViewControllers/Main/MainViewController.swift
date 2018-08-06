//
//  MainViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 8..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    let headerCellIdentifier: String = "MainHeaderCollectionViewCell"
    let cellIdentifier: String = "MainCollectionViewCell"

    @IBOutlet weak var letterView: UIView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
//    @IBAction func button(_ sender: Any) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "MyPage", bundle: nil)
//        if let vc = storyBoard.instantiateViewController(withIdentifier: "MyProductTable") as? MyProductTableViewController {
//
//            self.navigationController?.show(vc, sender: nil)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializing()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(checkAction))
        letterView.addGestureRecognizer(gesture)
    }

    @objc func checkAction(sender : UITapGestureRecognizer) {
        // Do what you want
        let storyBoard: UIStoryboard = UIStoryboard(name: "MyPage", bundle: nil)
        if let vc = storyBoard.instantiateViewController(withIdentifier: "MyProductTable") as? MyProductTableViewController {
            
            self.navigationController?.show(vc, sender: nil)
        }
    }
    
    
    @IBAction func leftButtonDidPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func rightButtonDidPressed(_ sender: Any) {

        
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


extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell: MainHeaderCollectionViewCell = self.productCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: self.headerCellIdentifier, for: indexPath) as? MainHeaderCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.headerTitle?.text = "실시간 상품"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MainCollectionViewCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.productImg?.image = UIImage(named: "rectangle4Copy")
        cell.nameLabel?.text = "상품 이름"
        cell.priceLabel?.text = "250,000원"
        
        return cell
    }
    
}



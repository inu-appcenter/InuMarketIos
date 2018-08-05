//
//  UploadPhotoViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 2..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit

class UploadPhotoViewController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadPhotoCollectionViewCell", for: indexPath) as! UploadPhotoCollectionViewCell
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5.0
        
        return cell
        
    }
    
    
//    func initializing() {
//        // button initializing
//        loginButton.layer.cornerRadius = 10.0
//        loginButton.layer.borderWidth = 1.0
//        loginButton.layer.borderColor = UIColor.white.cgColor
//        loginButton.layer.backgroundColor = UIColor.white.cgColor
//        loginButton.layer.masksToBounds = true
//        loginButton.layer.shadowColor = UIColor.lightGray.cgColor
//        loginButton.layer.shadowOffset = CGSize.zero
//        loginButton.layer.shadowRadius = 2.5
//        loginButton.layer.shadowOpacity = 0.8
//        loginButton.layer.masksToBounds = false
//    }
    
}

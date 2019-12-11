//
//  MainViewController.swift
//  InuMarket
//
//  Created by 김성은 on 04/12/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit
import ImageSlideshow

class MainViewController: UIViewController {
    
    var data: [[String]] = [["a","b"], ["1", "2", "3"], ["ㄱ", "ㄴ", "ㄷ", "ㄹ"]]

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.font = UIFont.NotoSansCJKKr(type: .regular, size: 16)
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        productCollectionView.register(ProductListCollectionViewCell.self, forCellWithReuseIdentifier: "ProductListCollectionViewCell")
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 48, height: 10))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 136)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCollectionViewCell", for: indexPath) as! ProductListCollectionViewCell
        
        cell.setData(data: data[indexPath.row])
        
        return cell
    }
}

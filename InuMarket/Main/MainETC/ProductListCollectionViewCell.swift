//
//  ProductListCollectionViewCell.swift
//  InuMarket
//
//  Created by 김성은 on 04/12/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    var data: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    func initCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceHorizontal = true
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        
        //let nibName = UINib(nibName: "ProductCell", bundle: nil)
        //self.collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        self.collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil).self, forCellWithReuseIdentifier: "ProductCell")
        
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                           self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                           self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                           self.collectionView.topAnchor.constraint(equalTo: self.topAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setData(data: [String]) {
        initCollectionView()
        self.data = data
    }
}

extension ProductListCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 9, left: 30, bottom: 25, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 166 , height: 102)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        //cell.backgroundColor = .clear
        cell.setText(text: data[indexPath.row])
        return cell
    }
    
}

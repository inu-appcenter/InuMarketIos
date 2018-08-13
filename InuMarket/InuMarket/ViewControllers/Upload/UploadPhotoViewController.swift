//
//  UploadPhotoViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 2..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import Photos
import BSImagePicker


class UploadPhotoViewController: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var albumAndCancel: UIButton!
    @IBOutlet weak var toPhotoAndDelete: UIButton!
    @IBOutlet weak var photoCollection: UICollectionView!
    
    var imageArray = [#imageLiteral(resourceName: "photo"),#imageLiteral(resourceName: "logo")]
    
    var SelectedAssets = [PHAsset]()
    var buttonCount = [0,1,2,3,4,5,6,7]
    var selectRow: Int?
    
    
    var category: String?
    var productName: String?
    var productState: String?
    var productPrice: String?
    var productInfo: String?
    var method: String?
    var place: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func nextButtonClicked(_ sender: Any) {
        if imageArray.count == 1{
        errorLabel.isHidden = false
        } else{
        if let vc = storyboard?.instantiateViewController(withIdentifier: "UploadPreView") as? UploadPreViewController{
            var postImageArray : [UIImage] = []
            for i in 1..<imageArray.count{
                postImageArray.append(imageArray[i])
            }
            vc.userfile = postImageArray
            vc.category = category
            vc.productName = productName
            vc.productState = productState
            vc.productPrice = productPrice
            vc.productInfo = productInfo
            vc.method = method
            vc.place = place
            self.navigationController?.show(vc, sender: nil)
        }
        }
    }
    @IBAction func toPhotoAndDeleteButtonClicked(_ sender: Any) {
        if toPhotoAndDelete.currentTitle == "삭제"{
            imageArray.remove(at: selectRow!)
            self.photoCollection.reloadData()
            endEventButton()
        }else{
            //            카메라키기
            endEventButton()
        }
        
    }
    
    
    // 접근이 허용되었는지 파악하는 함수
    func checkIfAuthorizedToAccessPhotos(_ handler: @escaping (_ isAuthorized: Bool) -> Void) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    switch status {
                    case .authorized:
                        handler(true)
                    default:
                        handler(false)
                    }
                }
            }
        case .restricted:
            handler(false)
        case .denied:
            handler(false)
        case .authorized:
            handler(true)
        }
    }
    
    @IBAction func albumAndCancelButtonClicked(_ sender: Any) {
        if albumAndCancel.currentTitle == "취소" {
            endEventButton()
        }else{
            // 접근이 허용되었는지 체크
            checkIfAuthorizedToAccessPhotos { isAuthorized in
                DispatchQueue.main.async(execute: {
                    if isAuthorized {
                        //접근허용일때
                        let imagePicker = BSImagePickerViewController()
                        imagePicker.maxNumberOfSelections = 7
                        self.bs_presentImagePickerController(imagePicker, animated: true,
                                                             select:
                            { (asset: PHAsset) -> Void in
                                print("Selected: \(asset)")
                        }, deselect: { (asset: PHAsset) -> Void in
                            print("Deselected: \(asset)")
                        }, cancel: { (assets: [PHAsset]) -> Void in
                            print("Cancel: \(assets)")
                        }, finish: { (assets: [PHAsset]) -> Void in
                            print("Finish: \(assets)")
                            for i in 0..<assets.count
                            {
                                self.SelectedAssets.append(assets[i])
                                print(self.SelectedAssets)
                            }
                            self.getAllImages()
                            self.SelectedAssets.removeAll()
                        }, completion: nil)
                    } else {
                        let alert = UIAlertController(title: "에러!", message: "앨범 접근을 허용해 주세요!", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                })
            }
        }
        endEventButton()
    }
    
    func getAllImages() -> Void {
        
        print("get all images method called here")
        if SelectedAssets.count != 0{
            
            for i in 0..<SelectedAssets.count{
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedAssets[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                })
                self.imageArray.append(thumbnail)
            }
            OperationQueue.main.addOperation {
                self.photoCollection.reloadData()
            }
        }
    }
    
    
    
    func initializing() {
        // button initializing
        albumAndCancel.layer.cornerRadius = 10.0
        albumAndCancel.layer.borderWidth = 1.0
        albumAndCancel.layer.borderColor = UIColor.white.cgColor
        albumAndCancel.layer.backgroundColor = UIColor.white.cgColor
        albumAndCancel.layer.masksToBounds = true
        albumAndCancel.layer.shadowColor = UIColor.lightGray.cgColor
        albumAndCancel.layer.shadowOffset = CGSize.zero
        albumAndCancel.layer.shadowRadius = 2.5
        albumAndCancel.layer.shadowOpacity = 0.8
        albumAndCancel.layer.masksToBounds = false
        
        toPhotoAndDelete.layer.cornerRadius = 10.0
        toPhotoAndDelete.layer.borderWidth = 1.0
        toPhotoAndDelete.layer.borderColor = UIColor.white.cgColor
        toPhotoAndDelete.layer.backgroundColor = UIColor.white.cgColor
        toPhotoAndDelete.layer.masksToBounds = true
        toPhotoAndDelete.layer.shadowColor = UIColor.lightGray.cgColor
        toPhotoAndDelete.layer.shadowOffset = CGSize.zero
        toPhotoAndDelete.layer.shadowRadius = 2.5
        toPhotoAndDelete.layer.shadowOpacity = 0.8
        toPhotoAndDelete.layer.masksToBounds = false
        // 다음 버튼에 빨간줄 추가
        let customSubview = UIView(frame: CGRect(x: 0, y: 0, width:  view.bounds.width, height: 2.0))
        customSubview.backgroundColor = .red
        customSubview.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        //        segmentControl.addSubviewToIndicator(customSubview)
        nextButton.addSubview(customSubview)
    }
    func endEventButton(){
        albumAndCancel.isEnabled = false
        albumAndCancel.isHidden = true
        toPhotoAndDelete.isHidden = true
        toPhotoAndDelete.isEnabled = false
        
    }
}



extension UploadPhotoViewController:UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadPhotoCollectionViewCell", for: indexPath) as! UploadPhotoCollectionViewCell
        
        cell.photoImage.image = imageArray[indexPath.row]
        
        //            cell.photoImage.image = self.assets![indexPath.row]
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5.0
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        selectRow = buttonCount[indexPath.row]
        print(imageArray[indexPath.row])
        if imageArray[indexPath.row] == #imageLiteral(resourceName: "photo"){
            emptyImage()
        }
        else{
            nonEmptyImage()
        }
    }
    func nonEmptyImage(){
        albumAndCancel.isHidden = false
        albumAndCancel.isEnabled = true
        toPhotoAndDelete.isEnabled = true
        toPhotoAndDelete.isHidden = false
        
        toPhotoAndDelete.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 102/255, alpha: 1.0)
        toPhotoAndDelete.setTitleColor(.white, for: .normal)
        toPhotoAndDelete.setTitle("삭제", for: .normal)
        
        
        albumAndCancel.setTitle("취소", for: .normal)
        albumAndCancel.setTitleColor(.black, for: .normal)
        
    }
    func emptyImage(){
        
        albumAndCancel.isHidden = false
        albumAndCancel.isEnabled = true
        toPhotoAndDelete.isEnabled = true
        toPhotoAndDelete.isHidden = false
        
        albumAndCancel.backgroundColor = UIColor.white
        albumAndCancel.setTitle("앨범(여러장)", for: .normal)
        albumAndCancel.setTitleColor(.black, for: .normal)
        
        toPhotoAndDelete.backgroundColor = UIColor.white
        toPhotoAndDelete.setTitle("촬영하기", for: .normal)
        toPhotoAndDelete.setTitleColor(.black, for: .normal)
        
    }
    
}

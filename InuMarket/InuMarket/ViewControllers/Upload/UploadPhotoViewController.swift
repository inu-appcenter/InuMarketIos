//
//  UploadPhotoViewController.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 2..
//  Copyright © 2018년 동균. All rights reserved.
//

import UIKit
import NohanaImagePicker
import Photos

class UploadPhotoViewController: UIViewController , UICollectionViewDataSource,UICollectionViewDelegate {

    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var albumAndCancel: UIButton!
    
    @IBOutlet weak var toPhotoAndDelete: UIButton!
    let picker = NohanaImagePickerController()

    var imageArray = [#imageLiteral(resourceName: "logo"),#imageLiteral(resourceName: "logo"),#imageLiteral(resourceName: "mainLogo")]
    override func viewDidLoad() {
        super.viewDidLoad()
        initializing()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
    }
    
    @IBAction func toPhotoAndDeleteButtonClicked(_ sender: Any) {
        
        picker.delegate = self
        
        // 접근이 허용되었는지 체크
        checkIfAuthorizedToAccessPhotos { isAuthorized in
            DispatchQueue.main.async(execute: {
                if isAuthorized {
                    self.present(self.picker, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "에러!", message: "앨범 접근을 허용해 주세요!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
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
    }
    
    
    @IBOutlet weak var photoCollection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 8
        return imageArray.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadPhotoCollectionViewCell", for: indexPath) as! UploadPhotoCollectionViewCell
        
        
//        cell.photoImage.image = imageArray[indexPath.row]
        
        cell.layer.borderWidth = 1.0
        cell.layer.cornerRadius = 5.0
        
        
        
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
    
    
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
    
}

extension UploadPhotoViewController: NohanaImagePickerControllerDelegate{
    
    
    
    func nohanaImagePickerDidCancel(_ picker: NohanaImagePickerController) {
        print("🐷Canceled🙅")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func nohanaImagePicker(_ picker: NohanaImagePickerController, didFinishPickingPhotoKitAssets pickedAssts: [PHAsset]) {
        print("🐷Completed🙆\n\tpickedAssets = \(pickedAssts)")
        picker.dismiss(animated: true, completion: nil)
    }
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            selectedImage = originalImage
//            if imageView1.image == nil{
//                imageView1.image = originalImage
//            }
//            if imageView2.image == nil{
//                imageView2.image = originalImage
//            }
//            if imageView3.image == nil{
//                imageView3.image = originalImage
//            }
//            if imageView4.image == nil{
//                imageView4.image = originalImage
//            }
//        }
    
}

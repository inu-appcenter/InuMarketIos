//
//  NetworkModel.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 11..
//  Copyright © 2018년 동균. All rights reserved.
//

import Foundation


import Alamofire
import UIKit

class NetworkModel{
//    private let serverURL = "http://117.16.231.66:7000/"
    var view : NetworkCallback
    
    init(_ view: NetworkCallback) {
        self.view = view
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    //로그인
    func login(id: String, passwd: String, FCM: String) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [ "id" : id,
                       "passwd" : passwd,
                       "FCM" : FCM]
        Alamofire.request("\(self.appDelegate.serverURL)login?", method: .post, parameters: params, headers: header).responseJSON { res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "loginSuccess")
                
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "loginError")
                break
            }
        }
    }
    
    //비밀번호 찾기
    func forgotPass(id: String, name: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [ "id" : id,
                       "name" : name]
        Alamofire.request("\(self.appDelegate.serverURL)stateChange/newPassword", method: .post, parameters: params, headers: header).responseJSON { res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "newPasswordSuccess")
                
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "newPasswordError")
                break
            }
        }
    }
    //회원가입
    func signUp(id : String, passwd: String, name: String, tel: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [ "id" : id,
                       "passwd" : passwd,
                       "name" : name,
                       "tel" : tel]
        Alamofire.request("\(self.appDelegate.serverURL)account", method: .post, parameters: params, headers: header).responseJSON { res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "signSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "signError")
                break
            }
        }
    }
    
    // 모든 제품 보기
    func allProduct(){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        Alamofire.request("\(self.appDelegate.serverURL)PSelect/main", method: .post, parameters: nil, headers: header).responseJSON{res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "allProductSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "allProductError")
                break
            }
        }

    }
//    제품 명 검색
    func searchProduct(productName: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["productName": productName ]
        Alamofire.request("\(self.appDelegate.serverURL)PSelect/search", method: .post, parameters: params, headers: header).responseJSON{res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "searchProductSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "searchProductError")
                break
            }
        }
        
    }
    // 카테고리 검색
    func categoryProduct(category: String) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = [ "category": category ]
        Alamofire.request("\(self.appDelegate.serverURL)PSelect/category", method: .post, parameters: params, headers: header).responseJSON{res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "categoryProductSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "categoryProductError")
                break
            }
        }
    }
    // 판매된 물건 리스트
    func myProductSelled(sellerId:String) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [ "sellerId": sellerId ]
        
        Alamofire.request("\(self.appDelegate.serverURL)PSelect/selled", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "myProductSell")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "SellError")
                break
            }
        }
    }
    // 판매중인 물건 리스트
    func myProductNonSell(sellerId:String) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [ "sellerId": sellerId ]
        
        Alamofire.request("\(self.appDelegate.serverURL)PSelect/nonsell", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "myProductNonSell")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "NonSellError")
                break
            }
        }
    }
    //    물건 판매 완료 처리
    func changeProduct(productId:String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["productId": productId]
        Alamofire.request("\(self.appDelegate.serverURL)stateChange/product", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "changeProductSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "changeProductError")
                break
            }
        }
    }
    //    비밀번호경변경
    func changePasswd(id: String, pastPasswd: String, newPasswd: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["id" : id,
                      "pastPasswd" : pastPasswd,
                      "newPasswd": newPasswd
        ]
        Alamofire.request("\(self.appDelegate.serverURL)stateChange/changePasswd", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "changePasswdSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "changePasswdError")
                break
            }
        }
    }
    // 회원탈퇴
    func deleteUser(id: String, passwd: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["id" : id,
                      "passwd": passwd
        ]
        Alamofire.request("\(self.appDelegate.serverURL)account/delete", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "deleteUserSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "deleteUserError")
                break
            }
        }
    }
    // 전화번호 변경
    func changePhone(id: String, newTel: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["id" : id,
                      "newTel": newTel
        ]
        Alamofire.request("\(self.appDelegate.serverURL)stateChange/changeTel", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "changePhoneSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "changePhoneError")
                break
            }
        }
    }
//    제품 업로드
    
    func uploadProduct(userfile: [UIImage] ,category: String, productName: String, productState:String, productPrice:String, productInfo:String, method:String, place: String, id: String){
        let params: Parameters = [
            "category" : category,
            "productName" : productName,
            "productState" : productState,
            "productPrice" : productPrice,
            "productInfo" : productInfo,
            "method" : method,
            "place" : place,
            "id": id
        ]
        Alamofire.upload(multipartFormData: { multipartFormData in
            for (key,value) in params {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            for index in 0..<userfile.count {
                var data = UIImagePNGRepresentation(userfile[index])
                if data != nil {
                    // PNG
                    multipartFormData.append(data!, withName: "userfile",fileName: "userfile", mimeType: "image/png")
                } else {
                    // jpg
                    data = UIImageJPEGRepresentation(userfile[index], 0.5)
                    multipartFormData.append((data?.base64EncodedData())!, withName: "userfile",fileName: "userfile", mimeType: "image/jpeg")
                }
            }
        },
            to: "\(self.appDelegate.serverURL)Pupload",
            headers: ["Content-Type" : "multipart/form-data",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"],
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON{ res in
                        switch res.result{
                        case .success(let item):
                            self.view.networkSuc(resultdata: item, code: "uploadProductSuccess")
                            break
                        case .failure(let error):
                            print(error)
                            self.view.networkFail(code: "uploadProductError")
                            break
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
    
//    제품 상세 정보
    func detailProduct(productId: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["productId":productId]
        
        Alamofire.request("\(self.appDelegate.serverURL)PSelect/oneItem", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "detailSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "detailError")
                break
            }
        }
    
    }
//    판매자 물건 리스트 조회
    func sellerIdSearchProduct(sellerId: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["sellerId":sellerId]
        
        Alamofire.request("\(self.appDelegate.serverURL)PSelect/searchId", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "sellerIdSearchSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "sellerIdSearchError")
                break
            }
        }
        
    }
    
    // 쪽지 보내기
    func letterSend(productId: String, custId: String, sellerId: String, productName: String, category: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["productId":productId,
                      "custId":custId,
                      "sellerId":sellerId,
                      "productName":productName,
                      "category":category]
        Alamofire.request("\(self.appDelegate.serverURL)letter/send", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "letterSendSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "letterSendError")
                break
            }
        }
        
    }
    // 쪽지 리스트
    func letterList(id: String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["id":id ]
        Alamofire.request("\(self.appDelegate.serverURL)letter/list", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "letterListSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "letterListError")
                break
            }
        }
        
    }
    
//    배너 리스트
    func bannerList(){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        
        Alamofire.request("\(self.appDelegate.serverURL)readBanner", method: .post, parameters: nil, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "bannerListSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "bannerListError")
                break
            }
        }
    }
    
//     문의, 신고 하기
    func moonHee(kind:String, senderId:String, context:String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["kind":kind ,
                      "senderId":senderId,
                      "context":context
        ]

        Alamofire.request("\(self.appDelegate.serverURL)report", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "reportSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "reportError")
                break
            }
        }
    }
//     신고
    func banReport(kind:String, senderId:String, productId:String){
        let header = ["Content-Type" : "application/x-www-form-urlencoded",
                      "x-access-token" : "\(self.appDelegate.userInfo?.token!)"]
        let params = ["kind":kind ,
                      "senderId":senderId,
                      "productId":productId
        ]
        
        Alamofire.request("\(self.appDelegate.serverURL)report", method: .post, parameters: params, headers: header).responseJSON{ res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "reportSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "reportError")
                break
            }
        }
    }
}



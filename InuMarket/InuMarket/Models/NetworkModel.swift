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
    private let serverURL = "http://117.16.231.66:7000/"
    var view : NetworkCallback
    
    init(_ view: NetworkCallback) {
        self.view = view
    }
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    //로그인
    func login(id: String, passwd: String) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [ "id" : id,
                       "passwd" : passwd]
        Alamofire.request("\(serverURL)login?", method: .post, parameters: params, headers: header).responseJSON { res in
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
        Alamofire.request("\(serverURL)stateChange/newPassword", method: .post, parameters: params, headers: header).responseJSON { res in
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
        Alamofire.request("\(serverURL)account", method: .post, parameters: params, headers: header).responseJSON { res in
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
    // 판매된 물건 리스트
    func myProductSelled(sellerId:String) {
        let header = ["Content-Type" : "application/x-www-form-urlencoded"]
        let params = [ "sellerId": sellerId ]
        
        Alamofire.request("\(serverURL)PSelect/selled", method: .post, parameters: params, headers: header).responseJSON{ res in
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
        
        Alamofire.request("\(serverURL)PSelect/nonsell", method: .post, parameters: params, headers: header).responseJSON{ res in
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
        Alamofire.request("\(serverURL)stateChange/product", method: .post, parameters: params, headers: header).responseJSON{ res in
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
        Alamofire.request("\(serverURL)stateChange/changePasswd", method: .post, parameters: params, headers: header).responseJSON{ res in
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
        Alamofire.request("\(serverURL)account/delete", method: .post, parameters: params, headers: header).responseJSON{ res in
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
    
}


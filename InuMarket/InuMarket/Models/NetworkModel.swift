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


    //로그인 테스트
    func login(param: String) {
        Alamofire.request("\(serverURL)login?\(param)", method: .post, parameters: nil, headers: nil).responseJSON { res in
            switch res.result{
            case .success(let item):
                self.view.networkSuc(resultdata: item, code: "loginSuccess")
                break
            case .failure(let error):
                print(error)
                self.view.networkFail(code: "loginError")
                break;
            }
        }
        
    }
}

class ViewModel{
    var view: ViewCallback
    
    init(_ view: ViewCallback){
        self.view = view
        
    }
    
    func letter() {
        self.view.viewSuc(code: "letter")
    }
}

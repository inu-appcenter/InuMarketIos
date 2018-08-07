//
//  DBManager.swift
//  InuMarket
//
//  Created by 동균 on 2018. 8. 5..
//  Copyright © 2018년 동균. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class SignResult{

    var ans : Bool?
    
    init(ans : Bool){
        self.ans = ans
    }
    
}


class UserInfo{
    var token: String?
    var id: String?
    var name: String?
    var tel: String?
    var message: String?
    
    init(token: String, id: String, name: String, tel: String, message: String) {
        self.token = token
        self.id = id
        self.name = name
        self.tel = tel
        self.message = message
    }
}

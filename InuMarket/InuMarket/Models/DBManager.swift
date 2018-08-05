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

class SignResult: Mappable{

    var ans : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.ans <- map["ans"]
    }
    
}

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

// 회원가입, 비밀번호 찾기, 비밀번호 변경 , 판매완료 변경, 회원탈퇴 , 제품 업로드
class AnsResult{

    var ans : Bool?
    
    init(ans : Bool){
        self.ans = ans
    }
    
}

// 로그인 사용자 정보
class UserInfo{
    var token: String?
    var id: String?
    var name: String?
    var tel: String?
    var message: String?
    var letter: Int?
    var product: Int?
    
    init(token: String, id: String, name: String, tel: String, message: String, letter: Int, product: Int) {
        self.token = token
        self.id = id
        self.name = name
        self.tel = tel
        self.message = message
        self.letter = letter
        self.product = product
    }
}

// 판매완료된 물품 리스트
class MyProductselled{
    var productImg: String?
    var productId: String?
    var productName: String?
    var productPrise: String?
    var productSelled: Bool?
    var sellerId: String?
    var updateDate: String?
    
    init(productImg: String ,productId: String, productName: String, productPrise: String,productSelled: Bool, sellerId: String, updateDate: String){
        self.productImg = productImg
        self.productId = productId
        self.productName = productName
        self.productPrise = productPrise
        self.productSelled = productSelled
        self.sellerId = sellerId
        self.updateDate = updateDate
    }
}

// 판매중인 물품 리스트
class MyProductNonsell{
    var productImg: String?
    var productId: String?
    var productName: String?
    var productPrise: String?
    var productSelled: Bool?
    var sellerId: String?
    var updateDate: String?
    
    init(productImg: String ,productId: String, productName: String, productPrise: String,productSelled: Bool, sellerId: String, updateDate: String){
        self.productImg = productImg
        self.productId = productId
        self.productName = productName
        self.productPrise = productPrise
        self.productSelled = productSelled
        self.sellerId = sellerId
        self.updateDate = updateDate
    }
}



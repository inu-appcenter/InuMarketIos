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

// 회원가입, 비밀번호 찾기, 비밀번호 변경 , 판매완료 변경, 회원탈퇴 , 제품 업로드 , 쪽지 전송
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
    var category: String?

    init(productImg: String ,productId: String, productName: String, productPrise: String,productSelled: Bool, sellerId: String, updateDate: String, category: String){
        self.productImg = productImg
        self.productId = productId
        self.productName = productName
        self.productPrise = productPrise
        self.productSelled = productSelled
        self.sellerId = sellerId
        self.updateDate = updateDate
        self.category = category
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
    var category: String?

    init(productImg: String ,productId: String, productName: String, productPrise: String,productSelled: Bool, sellerId: String, updateDate: String, category:String){
        self.productImg = productImg
        self.productId = productId
        self.productName = productName
        self.productPrise = productPrise
        self.productSelled = productSelled
        self.sellerId = sellerId
        self.updateDate = updateDate
        self.category = category
    }
}

// 전체 물건 리스트 , 카테고리 검색 물건 리스트 , 판매자 물건 리스트

class AllProduct{
    var productImg: [String]?
    var productId: String?
    var productName: String?
    var productPrice: Int?
    var category: String?
    var productSelled: Bool?
    var updateDate: String?
    
    init(productImg: [String] ,productId: String, productName: String, productPrice: Int, productSelled: Bool, category: String, updateDate: String){
        self.productImg = productImg
        self.productId = productId
        self.productName = productName
        self.productPrice = productPrice
        self.productSelled = productSelled
        self.category = category
        self.updateDate = updateDate
    }
}

// 물건 상세 정보
class detailProduct{
    var productImg: [String]?
    var productId: String?
    var productName: String?
    var productState: String?
    var productStar: Int?
    var productPrice: Int?
    var productSelled: Bool?
    var category: String?
    var productInfo: String?
    var method: String?
    var place: String?
    var sellerId: String?
    var updateDate: String?
    var sellerName: String?
    var sellerPhone: String?
    
    init(productImg: [String], productId:String,productName:String, productState:String, productStar:Int, productPrice:Int, productSelled:Bool, category:String, productInfo:String, method:String, place:String, sellerId:String, updateDate:String ,sellerName: String, sellerPhone: String){
        self.productImg = productImg
        self.productId = productId
        self.productName = productName
        self.productState = productState
        self.productStar = productStar
        self.productPrice = productPrice
        self.productSelled = productSelled
        self.category = category
        self.productInfo = productInfo
        self.method = method
        self.place = place
        self.sellerId = sellerId
        self.updateDate = updateDate
        self.sellerName = sellerName
        self.sellerPhone = sellerPhone
    }
}

// 쪽지함 리스트
class LetterList{
    var letterId : String?
    var sendId: String?
    var reciveId: String?
    var sellBuy: Bool?
    var letterRead : Bool?
    var productId : String?
    var productName: String?
    var sendDate: String?
    var senderPhone: String?
    var productSelled: Bool?
    var senderName: String?
    init(letterId: String, sendId: String, reciveId: String, sellBuy: Bool, letterRead: Bool, productId: String, productName: String, sendDate: String, senderPhone: String, productSelled: Bool, senderName: String) {
        self.letterId = letterId
        self.sendId = sendId
        self.reciveId = reciveId
        self.sellBuy = sellBuy
        self.letterRead = letterRead
        self.productId = productId
        self.productName = productName
        self.sendDate = sendDate
        self.senderPhone = senderPhone
        self.productSelled = productSelled
        self.senderName = senderName
    }
}



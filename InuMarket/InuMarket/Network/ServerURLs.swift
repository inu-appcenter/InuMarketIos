//
//  ServerURLs.swift
//  InuMarket
//
//  Created by 김성은 on 18/03/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import Foundation

enum ServerURLs: String {
    case base = "http://117.16.231.66:7000/"
    
    // 판매중->판매완료
    case product = "stateChange/product"
    // 물건업로드
    case pUpload = "Pupload"
    // 전체 물건 로드
    case main = "PSelect/main"
    // 물건이름으로 검색
    case search = "PSelect/search"
    // 물품 상세 조회
    case oneItem = "PSelect/oneItem"
    // 판매중물건 조회
    case nonsell = "PSelect/nonsell"
    // 판매완료물건 조회
    case selled = "PSelect/selled"
    // 판매자 물건 조회
    case searchId = "PSelect/searchId"
    // 카테고리 검색
    case category = "PSelect/category"
    // 카테고리 내 검색
    case categorysearch = "PSelect/categorysearch"
    
    // 회원가입기능
    case account = "account"
    // 로그인기능
    case login = "login"
    // 비밀번호 변경 기능
    case changePasswd = "stateChange/changePasswd"
    // 비밀번호 찾기
    case newPassword = "stateChange/newPassword"
    // 회원탈퇴
    case delete = "account/delete"
    // 핸드폰 번호 변경
    case changeTel = "stateChange/changeTel"
    // 상품이미지 링크
    case imgload = "imgload/"
    
    // 배너 링크
    case readBanner = "readBanner"
    
    // 문의하기, 신고하기
    case report = "report"
}

//
//  NetworkCallback.swift
//  InuMarket
//
//  Created by 동균 on 2018. 7. 12..
//  Copyright © 2018년 동균. All rights reserved.
//

import Foundation

protocol NetworkCallback {
    func networkSuc(resultdata : Any, code: String, tag: Int)
    func networkFail(code: String)
}

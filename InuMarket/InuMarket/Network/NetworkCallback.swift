//
//  NetworkCallback.swift
//  InuMarket
//
//  Created by 김성은 on 19/03/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import Foundation

protocol NetworkCallback {
    func networkSuccess(resultData: Any?, code: String)
    func networkFailed(errMessage: String, code: String)
}

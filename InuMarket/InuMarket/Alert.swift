//
//  Alert.swift
//  InuMarket
//
//  Created by 김성은 on 15/03/2019.
//  Copyright © 2019 김성은. All rights reserved.
//

import UIKit

class Alert {
    static func oneAlert(title: String? = "오류",
                         message: String?,
                         actionTitle: String? = "확인",
                         actionHandler: ((UIAlertAction) -> (Void))? = nil) -> UIAlertController
    {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(
            title: actionTitle,
            style: .default,
            handler: actionHandler
        )
        
        alert.addAction(action)
        
        alert.view.tintColor = UIColor.MainColor
        
        return alert
    }
    
    static func twoAlert(title: String?,
                         message: String?,
                         actionOneTitle: String?,
                         actionTwoTitle: String?,
                         actionOneHandler: ((UIAlertAction) -> (Void))? = nil,
                         actionTwoHandler: ((UIAlertAction) -> (Void))? = nil) -> UIAlertController
    {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let actionOne = UIAlertAction(
            title: actionOneTitle,
            style: .default,
            handler: actionOneHandler
        )
        
        let actionTwo = UIAlertAction(
            title: actionTwoTitle,
            style: .default,
            handler: actionTwoHandler)
        
        alert.addAction(actionOne)
        alert.addAction(actionTwo)
        
        alert.view.tintColor = UIColor.MainColor
        
        return alert
    }
    
    static func twoAndCancelSheet(title: String? = nil,
                                  message: String? = nil,
                                  actionOneTitle: String?,
                                  actionTwoTitle: String?,
                                  cancelTitle: String?,
                                  actionOneHandler: ((UIAlertAction) -> (Void))? = nil,
                                  actionTwoHandler: ((UIAlertAction) -> (Void))? = nil,
                                  cancelHandler: ((UIAlertAction) -> (Void))? = nil) -> UIAlertController
    {
        let sheet = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .actionSheet
        )
        
        let actionOne = UIAlertAction(
            title: actionOneTitle,
            style: .default,
            handler: actionOneHandler
        )
        
        let actionTwo = UIAlertAction(
            title: actionTwoTitle,
            style: .default,
            handler: actionTwoHandler
        )
        
        let cancel = UIAlertAction(
            title: cancelTitle,
            style: .cancel,
            handler: cancelHandler
        )
        
        sheet.addAction(actionOne)
        sheet.addAction(actionTwo)
        sheet.addAction(cancel)
        
        sheet.view.tintColor = UIColor.MainColor
        
        return sheet
    }
}

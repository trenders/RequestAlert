//
//  RequestAlert.swift
//  RequestAlert
//
//  Created by HARA KENTA on 2016/03/07.
//  Copyright © 2016年 Hara Kenta. All rights reserved.
//

import Foundation
import UIKit
public struct RequestAlert {
    
    fileprivate static var requestAlertInstancesDic = [String: RequestAlert]()
    
    fileprivate static let kBundleId = "harakenta.RequestAlert."
    
    fileprivate static let kUdCountKeyBase = kBundleId + "udCountKeyBase."
    fileprivate static let kUdDisplayedNumKeyBase = kBundleId + "udDisplayedNumKeyBase."
    fileprivate static let kUdHasBeenPushedOKButtonKeyBase = kBundleId + "udHasBeenPushedOKButtonKeyBase."
    
    fileprivate var alertId: String
    fileprivate var intervalCount: Int
    fileprivate var alertTitle: String
    fileprivate var message: String
    fileprivate var cancelButtonTitle: String
    fileprivate var OKButtonTitle: String
    
    init(
        alertId: String,
        intervalCount: Int,
        alertTitle: String,
        message: String,
        cancelButtonTitle: String,
        OKButtonTitle: String)
    {
        self.alertId = alertId
        self.intervalCount = intervalCount
        self.alertTitle = alertTitle
        self.message = message
        self.cancelButtonTitle = cancelButtonTitle
        self.OKButtonTitle = OKButtonTitle
    }
    
    public static func addRequestAlert(
        id: String,
        intervalCount: Int,
        alertTitle: String,
        message: String,
        cancelButtonTitle: String,
        OKButtonTitle: String)
    {
        let requestAlert = RequestAlert(
            alertId: id,
            intervalCount: intervalCount,
            alertTitle: alertTitle,
            message: message,
            cancelButtonTitle: cancelButtonTitle,
            OKButtonTitle: OKButtonTitle)
        
        requestAlertInstancesDic[id] = requestAlert
    }
    
    public static func showAlert(id: String, pushedOKButtonClosure: (() -> Void)?) {
        guard let alert = requestAlertInstancesDic[id] else { fatalError("There is no alert id : \(id)") }
        
        alert.showAlertController(pushedOKButtonClosure: pushedOKButtonClosure)
        
    }

    public static func incrementCount(id: String, pushedOKButtonClosure: (() -> Void)? ){

        var currentCount = UserDefaults.standard.integer(forKey: udCountKey(alertId: id))
        currentCount += 1
        
        guard let alert = requestAlertInstancesDic[id] else { fatalError("There is no alert id : \(id)") }
        
        if alert.shouldShowAlertController(currentCount: currentCount) {
            alert.showAlertController(pushedOKButtonClosure: pushedOKButtonClosure)
        } else {
            UserDefaults.standard.set(currentCount, forKey: udCountKey(alertId: id))
            UserDefaults.standard.synchronize()
        }
    }
    
    public static func hasBeenDisplayed(id: String) -> Bool {
        let udKey = udDisplayedNumKey(alertId: id)
        let hasBeenDisplayed = UserDefaults.standard.bool(forKey: udKey)
        
        return hasBeenDisplayed
    }
    
    public static func hasBeenPushedOKButton(id: String) -> Bool {
        let udKey = udHasBeenPushedOKButtonKey(alertId: id)
        let hasBeenPushedOKButton = UserDefaults.standard.bool(forKey: udKey)
        
        return hasBeenPushedOKButton
    }
    
    //MARK: - private methods
    
    fileprivate static func udCountKey(alertId: String) -> String {
        return kUdCountKeyBase + alertId
    }
    
    fileprivate static func udDisplayedNumKey(alertId: String) -> String {
        return kUdDisplayedNumKeyBase + alertId
    }
    
    fileprivate static func udHasBeenPushedOKButtonKey(alertId: String) -> String {
        return kUdHasBeenPushedOKButtonKeyBase + alertId
    }
    
    fileprivate func shouldShowAlertController(currentCount: Int) -> Bool {
        return currentCount >= intervalCount
    }
    
    fileprivate func showAlertController(pushedOKButtonClosure: (() -> Void)?) {
        UserDefaults.standard.set(0, forKey: type(of: self).udCountKey(alertId: alertId))
        
        let alertController = UIAlertController(
            title: alertTitle,
            message: message,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: cancelButtonTitle,
            style: .cancel,
            handler: nil))
        
        alertController.addAction(UIAlertAction(
            title: OKButtonTitle,
            style: .default,
            handler: { (action) -> Void in
                pushedOKButtonClosure?()
                UserDefaults.standard.set(true, forKey: type(of: self).udHasBeenPushedOKButtonKey(alertId: self.alertId))
                UserDefaults.standard.synchronize()
        }))
        
        let currentVC = currentViewController()
        
        currentVC.present(alertController, animated: true, completion: nil)
        
        incrementDisplayedNum()
    }
    
    fileprivate func currentViewController() -> UIViewController {
        
        guard var baseView = UIApplication.shared.keyWindow?.rootViewController else { fatalError("There is no rootViewController") }
        
        while baseView.presentedViewController != nil && !baseView.presentedViewController!.isBeingDismissed {
            baseView = baseView.presentedViewController!
        }
        
        return baseView
    }
    
    fileprivate func incrementDisplayedNum() {
        var currentDisplayedNum = UserDefaults.standard.integer(forKey: type(of: self).udDisplayedNumKey(alertId: alertId))
        currentDisplayedNum += 1
        
        UserDefaults.standard.set(currentDisplayedNum, forKey: type(of: self).udDisplayedNumKey(alertId: alertId))
        UserDefaults.standard.synchronize()
    }
}

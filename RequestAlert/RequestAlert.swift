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
    
    private static var requestAlertInstancesDic = [String: RequestAlert]()
    
    private static let kBundleId = "harakenta.RequestAlert."
    
    private static let kUdCountKeyBase = kBundleId + "udCountKeyBase."
    private static let kUdDisplayedNumKeyBase = kBundleId + "udDisplayedNumKeyBase."
    private static let kUdHasBeenPushedOKButtonKeyBase = kBundleId + "udHasBeenPushedOKButtonKeyBase."
    
    private var alertId: String
    private var intervalCount: Int
    private var alertTitle: String
    private var message: String
    private var cancelButtonTitle: String
    private var OKButtonTitle: String
    
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
        id id: String,
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
    
    public static func showAlert(id id: String, pushedOKButtonClosure: (() -> Void)?) {
        guard let alert = requestAlertInstancesDic[id] else { fatalError("There is no alert id : \(id)") }
        
        alert.showAlertController(pushedOKButtonClosure: pushedOKButtonClosure)
        
    }

    public static func incrementCount(id id: String, pushedOKButtonClosure: (() -> Void)? ){

        var currentCount = NSUserDefaults.standardUserDefaults().integerForKey(udCountKey(alertId: id))
        currentCount++
        
        guard let alert = requestAlertInstancesDic[id] else { fatalError("There is no alert id : \(id)") }
        
        if alert.shouldShowAlertController(currentCount: currentCount) {
            alert.showAlertController(pushedOKButtonClosure: pushedOKButtonClosure)
        }
    }
    
    public static func hasDisplayed(id id: String) -> Bool {
        let udKey = udDisplayedNumKey(alertId: id)
        let hasDisplayed = NSUserDefaults.standardUserDefaults().boolForKey(udKey)
        
        return hasDisplayed
    }
    
    public static func hasBeenPushedOKButton(id id: String) -> Bool {
        let udKey = udHasBeenPushedOKButtonKey(alertId: id)
        let hasBeenPushedOKButton = NSUserDefaults.standardUserDefaults().boolForKey(udKey)
        
        return hasBeenPushedOKButton
    }
    
    //MARK: - private methods
    
    private static func udCountKey(alertId alertId: String) -> String {
        return kUdCountKeyBase + alertId
    }
    
    private static func udDisplayedNumKey(alertId alertId: String) -> String {
        return kUdDisplayedNumKeyBase + alertId
    }
    
    private static func udHasBeenPushedOKButtonKey(alertId alertId: String) -> String {
        return kUdHasBeenPushedOKButtonKeyBase + alertId
    }
    
    private func shouldShowAlertController(currentCount currentCount: Int) -> Bool {
        return currentCount >= intervalCount
    }
    
    private func showAlertController(pushedOKButtonClosure pushedOKButtonClosure: (() -> Void)?) {
        NSUserDefaults.standardUserDefaults().setInteger(0, forKey: self.dynamicType.udCountKey(alertId: alertId))
        
        let alertController = UIAlertController(
            title: alertTitle,
            message: message,
            preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(
            title: cancelButtonTitle,
            style: .Cancel,
            handler: nil))
        
        alertController.addAction(UIAlertAction(
            title: OKButtonTitle,
            style: .Default,
            handler: { (action) -> Void in
                pushedOKButtonClosure?()
        }))
        
        let currentVC = currentViewController()
        
        currentVC.presentViewController(alertController, animated: true, completion: nil)
        
        incrementDisplayedNum()
    }
    
    private func currentViewController() -> UIViewController {
        
        guard var baseView = UIApplication.sharedApplication().keyWindow?.rootViewController else { fatalError("There is no rootViewController") }
        
        while baseView.presentedViewController != nil && !baseView.presentedViewController!.isBeingDismissed() {
            baseView = baseView.presentedViewController!
        }
        
        return baseView
    }
    
    private func incrementDisplayedNum() {
        var currentDisplayedNum = NSUserDefaults.standardUserDefaults().integerForKey(self.dynamicType.udDisplayedNumKey(alertId: alertId))
        currentDisplayedNum++
        
        NSUserDefaults.standardUserDefaults().setInteger(currentDisplayedNum, forKey: self.dynamicType.udDisplayedNumKey(alertId: alertId))
    }
}

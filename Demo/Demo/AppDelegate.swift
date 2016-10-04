//
//  AppDelegate.swift
//  Demo
//
//  Created by HARA KENTA on 2016/03/07.
//  Copyright © 2016年 Hara Kenta. All rights reserved.
//

import UIKit
import RequestAlert

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        setUpRequestAlerts()
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func setUpRequestAlerts() {
        
        RequestAlert.addRequestAlert(
            id: RequestAlertType.pushNotification.id,
            intervalCount: 10,
            alertTitle: "Please turn on the push notification",
            message: "When you turn on the notification, it will deliver the new information in the notification",
            cancelButtonTitle: "cancel",
            OKButtonTitle: "OK")
        
        RequestAlert.addRequestAlert(
            id: RequestAlertType.review.id,
            intervalCount: 5,
            alertTitle: "Review Request!!!",
            message: "Please tell me your opinion",
            cancelButtonTitle: "later",
            OKButtonTitle: "review")
        
        RequestAlert.addRequestAlert(
            id: RequestAlertType.share.id,
            intervalCount: 2,
            alertTitle: "Please share",
            message: "Why do not you share?",
            cancelButtonTitle: "no thanks",
            OKButtonTitle: "OK")
    }
}


//
//  ViewController.swift
//  Demo
//
//  Created by HARA KENTA on 2016/03/07.
//  Copyright © 2016年 Hara Kenta. All rights reserved.
//

import UIKit
import RequestAlert

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {

        super.viewDidAppear(animated)
        
        RequestAlert.showAlert(id: RequestAlertType.pushNotification.id) {
            
            print("push OK button of Request Alert of type of push notification")
        }
        
        if RequestAlert.hasDisplayed(id: RequestAlertType.review.id) {
            
            print("review request alert has been displayed")
        }
        
        if RequestAlert.hasBeenPushedOKButton(id: RequestAlertType.share.id) {
            
            print("share request alert has been pushed OK Button")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pushedPushNotificationButton(sender: AnyObject) {
        
        RequestAlert.incrementCount(id: RequestAlertType.pushNotification.id) { 
            
            print("push OK button of Request Alert of type of push notification")
        }
    }

    @IBAction func pushedReviewButton(sender: AnyObject) {
        
        RequestAlert.incrementCount(id: RequestAlertType.review.id) { 
            
            print("push OK button of Request Alert of type of review")
        }
    }

    @IBAction func pushedShareButton(sender: AnyObject) {
        
        RequestAlert.incrementCount(id: RequestAlertType.share.id) { 
            
            print("push OK button of Request Alert of type of share")
        }
    }
}


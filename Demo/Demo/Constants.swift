//
//  Constants.swift
//  Demo
//
//  Created by HARA KENTA on 10/4/16.
//  Copyright © 2016 Hara Kenta. All rights reserved.
//

import Foundation

enum RequestAlertType {

    case pushNotification
    case review
    case share

    var id: String {
        
        switch self {
        case .pushNotification:
            return "requestAlertIdentifierPushNotification"
        
        case .review:
            return "requestAlertIdentifierReview"
            
        case .share:
            return "requestAlertIdentifierShare"
        }
    }
}

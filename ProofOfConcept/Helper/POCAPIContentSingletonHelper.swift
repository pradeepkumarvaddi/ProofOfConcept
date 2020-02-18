//
//  POCAPIContentSingletonHelper.swift
//  TelstraAssingment
//
//  Created by Pradeep Kumar Vadde (Digital) on 13/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import Foundation
import CDAlertView

final class POCAPIContentSingletonHelper
{
    // Singleton Syntax
    private init() {}
    static let sharedInstance = POCAPIContentSingletonHelper()
    
    //MARK: Error Popup
    func showErrorPopupWith(title: String, message: String)
    {
        DispatchQueue.main.async {
            let errorPopup = CDAlertView(title: title, message: message, type: .error)
            let okAction = CDAlertViewAction(title: Constants.OK)
            
            errorPopup.add(action: okAction)
            errorPopup.hideAnimations = { (center, transform, alpha) in
                center = CGPoint(x: 200, y: 1500)
                transform = .identity
                alpha = 0
            }
            errorPopup.hideAnimationDuration = 0.5
            errorPopup.show() { (alert) in
            }
        }
    }
}

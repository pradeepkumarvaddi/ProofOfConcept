//
//  UIView+Ext.swift
//  TableViewCustomCell
//
//  Created by Pradeep Kumar Vadde (Digital) on 10/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import UIKit

extension UIView {
    func pin (to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.topAnchor).isActive  = true
        leadingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview!.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

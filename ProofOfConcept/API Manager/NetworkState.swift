//
//  NetworkManager.swift
//  TableViewCustomCell
//
//  Created by Pradeep Kumar Vadde (Digital) on 12/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import Foundation
import Alamofire

class NetworkState: NSObject {
    class func isConnected() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

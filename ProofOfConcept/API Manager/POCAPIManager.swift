//
//  POCAPIManger.swift
//  TelstraAssingment
//
//  Created by Pradeep Kumar Vadde (Digital) on 13/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import Foundation
import UIKit

typealias dataRequestCompletionHandler = (_ success:Bool, _ data: [ContentModel]?, _ title: String?) -> ()

class POCAPIManager : NSObject {
    
    static let shareInstance = POCAPIManager()
    
     func getAllContentData(completionHandler: @escaping dataRequestCompletionHandler){
           guard let url = URL(string: Constants.BASE_URL) else { return }
           var navTitle = ""
           var rowsData: [ContentModel] = []
           URLSession.shared.dataTask(with: url) { data, response, error in
               if let data = data {
                   do {
                       let utf8Data = String(decoding: data, as: UTF8.self)
                       let convertedData = Data(utf8Data.utf8)
                       print("convertedData-\(convertedData)")
                       let jsonResult = try JSONSerialization.jsonObject(with: convertedData, options: [])
                       if let jsonResult = jsonResult as? Dictionary<String, Any>, let arrRows = jsonResult["rows"] as? [Dictionary<String, Any>] {
                           if jsonResult["title"] != nil {
                               navTitle =  jsonResult["title"] as! String
                           }
                           // Array of ROWs
                           for row in arrRows {
                               let title = row["title"]
                               if !(title is NSNull) {
                                   let description =  row["description"] is NSNull ? "" : row["description"]!
                                   let imgUrl = row["imageHref"] is NSNull ? "" : row["imageHref"]!
    
                                   let data : ContentModel = ContentModel(title: title as! String, description: description as! String, imageHref: imgUrl as! String)
                                   rowsData.append(data)
                               }
                           }
                       }
                       completionHandler(true, rowsData, navTitle)
                   } catch let error {
                       print(error)
                       completionHandler(false, rowsData, navTitle)
                   }
               }
           }.resume()
       }
}

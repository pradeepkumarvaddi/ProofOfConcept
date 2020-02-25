//
//  POCContentModel.swift
//  TelstraAssingment
//
//  Created by Pradeep Kumar Vadde (Digital) on 13/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import Foundation
import UIKit

class ContentModel: Decodable {
    var title: String?
    var description: String?
    var imageHref: String?
    
    init(title:String, description: String, imageHref: String){
        self.title = title
        self.description = description
        self.imageHref = imageHref
    }
}

class ResultsModel: Decodable {
    
    var results = [ContentModel]()
    
    init(results: [ContentModel]) {
        self.results = results
    }
}

//
//  ContentViewModel.swift
//  ProofOfConcept
//
//  Created by PradeepV on 25/02/20.
//  Copyright © 2020 Wipro Technologies. All rights reserved.
//

import UIKit

class ContentViewModel: NSObject {

    var title: String?
    var descriptions: String?
    var imageHref: String?
    
    // D I
    
    init(content:ContentModel){
        self.title = content.title
        self.descriptions = content.description
        self.imageHref = content.imageHref
    }
}

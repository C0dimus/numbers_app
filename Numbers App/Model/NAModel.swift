//
//  NAModel.swift
//  Numbers App
//
//  Created by Mac on 8/4/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import Foundation

struct NAModel {
    let name: String
    let text: String?
    let image: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.text = dictionary["text"] as? String
        self.image = dictionary["image"] as? String ?? ""
    }
}

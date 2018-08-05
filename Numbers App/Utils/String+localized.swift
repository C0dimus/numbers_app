//
//  String+localized.swift
//  Numbers App
//
//  Created by Mac on 8/5/18.
//  Copyright © 2018 C0dimus. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

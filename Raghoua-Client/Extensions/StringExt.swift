//
//  StringExt.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/27/21.
//

import Foundation

extension String {
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
}

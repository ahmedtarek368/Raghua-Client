//
//  UIButtonExt.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/3/21.
//

import UIKit

extension UIButton {
    
    func makeUnderLinedString(){
        let attributes = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underLineAttributedString = NSAttributedString(string: self.currentTitle!, attributes: attributes)
        self.titleLabel?.attributedText = underLineAttributedString
    }
}

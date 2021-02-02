//
//  digitsTextField.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit

class codeDigitsTextField: UITextField{

    override func awakeFromNib(){
        super.awakeFromNib()
        customizeTextField()
    }

    func customizeTextField(){
        keyboardType = UIKeyboardType.asciiCapableNumberPad
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        layer.cornerRadius = 8
        clipsToBounds = true
        font = UIFont.systemFont(ofSize: 24, weight: .bold)
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
}

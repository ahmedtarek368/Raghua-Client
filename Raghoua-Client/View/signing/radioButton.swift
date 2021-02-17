//
//  radioButton.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/31/21.
//

import UIKit

class radioButton: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        notSelectedRadioButton()
    }

    func notSelectedRadioButton(){
        let nonSelectedBorderWidth: CGFloat = 3
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = layer.frame.size.height/2
        layer.borderColor = #colorLiteral(red: 0.7882352941, green: 0.7882352941, blue: 0.7882352941, alpha: 1)
        layer.borderWidth = nonSelectedBorderWidth
    }
    
    func isSelectedRadioButton(){
        let selectedBorderWidth: CGFloat = 5
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.borderColor = #colorLiteral(red: 0.9568627451, green: 0.4117647059, blue: 0.2745098039, alpha: 1)
        layer.cornerRadius = layer.frame.size.height/2
        layer.borderWidth = selectedBorderWidth
    }
}

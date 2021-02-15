//
//  basicTextField.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/28/21.
//

import UIKit

class basicTextField: UITextField, UITextFieldDelegate {

    override func awakeFromNib(){
        delegate = self
        super.awakeFromNib()
        customizeTextField()
    }

    func customizeTextField(){
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        layer.cornerRadius = 8
        clipsToBounds = true
        if "lang".localized == "en"{
            textAlignment = .left
        }else{
            textAlignment = .right
        }
        textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        if let placeHolder = placeholder{
            let attributedPlaceHolder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7294117647, alpha: 1)])
            attributedPlaceholder = attributedPlaceHolder
        }
    }
    
    func isUnderlinedTextField() {
        
        layer.borderWidth = 0
        layer.cornerRadius = 0
        layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: layer.frame.size.height - 1.5 , width: layer.frame.width, height: 1.5)
        bottomLine.backgroundColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        layer.addSublayer(bottomLine)
        autocorrectionType = .no
        autocapitalizationType = .none
    }
    
    func isTransparentTextField(){
        layer.borderWidth = 0
        self.borderStyle = .none
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
        if let placeHolder = placeholder{
            let attributedPlaceHolder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6274509804, green: 0.6392156863, blue: 0.6549019608, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)])
            attributedPlaceholder = attributedPlaceHolder
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

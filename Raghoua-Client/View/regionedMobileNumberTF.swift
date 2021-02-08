//
//  mobileNumberTextField.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit

class regionedMobileNumberTF: UITextField {
    
    override func awakeFromNib(){
        super.awakeFromNib()
        customizeTextField()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let TextPadding = UIEdgeInsets(
            top: 0,
            left: 60,
            bottom: 0,
            right:0
        )
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: TextPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let TextPadding = UIEdgeInsets(
            top: 0,
            left: 60,
            bottom: 0,
            right: 0
        )
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: TextPadding)
    }
//    
//    override func didAddSubview(_ subview: UIView) {
//        regionTextField.frame = CGRect(x: 10, y: 0, width: 50, height: self.frame.size.height)
//        regionTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        regionTextField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        regionTextField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
//        regionTextField.textAlignment = .center
//        regionTextField.keyboardType = UIKeyboardType.phonePad
//        let attributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7294117647, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)] as [NSAttributedString.Key : Any]
//        let attributedPlaceHolder = NSAttributedString(string: "+966", attributes: attributes)
//        regionTextField.attributedPlaceholder = attributedPlaceHolder
//        
//    }
    func addRegionCodeField(codeField: UITextField){
        codeField.frame = CGRect(x: 10, y: 0, width: 50, height: self.frame.size.height)
        codeField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        codeField.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        codeField.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        codeField.textAlignment = .center
        codeField.keyboardType = UIKeyboardType.phonePad
        let attributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7294117647, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)] as [NSAttributedString.Key : Any]
        let attributedPlaceHolder = NSAttributedString(string: "+966", attributes: attributes)
        codeField.attributedPlaceholder = attributedPlaceHolder
            
        self.addSubview(codeField)
    }

    func customizeTextField(){
        
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        layer.cornerRadius = 8
        clipsToBounds = true
        
        textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let attributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.7176470588, green: 0.7176470588, blue: 0.7294117647, alpha: 1)] as [NSAttributedString.Key : Any]
        if let placeHolder = placeholder{
            let attributedPlaceHolder = NSAttributedString(string: placeHolder, attributes:attributes)
            attributedPlaceholder = attributedPlaceHolder
        }
        //addSubview(regionTextField)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

}

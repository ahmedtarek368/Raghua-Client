//
//  passwordTextField.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/28/21.
//

import UIKit

class passwordTextField: UITextField, UITextFieldDelegate{
    
    let eyeBtn = UIButton(type: .custom)
    var isVisible = false
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let englishTextPadding = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 41
        )
        let arabicTextPadding = UIEdgeInsets(
            top: 0,
            left: 41,
            bottom: 0,
            right:0
        )
        let rect = super.textRect(forBounds: bounds)
        if "lang".localized == "en"{
            return rect.inset(by: englishTextPadding)
        }else{
            return rect.inset(by: arabicTextPadding)
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let englishTextPadding = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 41
        )
        let arabicTextPadding = UIEdgeInsets(
            top: 0,
            left: 41,
            bottom: 0,
            right:0
        )
        let rect = super.editingRect(forBounds: bounds)
        if "lang".localized == "en"{
            return rect.inset(by: englishTextPadding)
        }else{
            return rect.inset(by: arabicTextPadding)
        }
    }
    
    override func awakeFromNib(){
        super.awakeFromNib()
        customizeTextField()
        customEyeBtn()
    }
    
    override func didAddSubview(_ subview: UIView) {
        if "lang".localized == "en"{
            eyeBtn.frame = CGRect(x: self.frame.size.width-41, y: (self.frame.size.height/2)-12, width: 24.0, height: 24.0)
        }else{
            eyeBtn.frame = CGRect(x: 16, y: (self.frame.size.height/2)-12, width: 24, height: 24)
        }
    }
    
    func customizeTextField(){
        keyboardType = UIKeyboardType.alphabet
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

    func customEyeBtn(){
        print("customEyeBtn")
        let textFieldHeight = self.frame.size.height
        let textFieldWidth = self.frame.size.width
        
        eyeBtn.addTarget(self, action: #selector(eyeBtnTapped), for: .touchUpInside)
        if "lang".localized == "en"{
            eyeBtn.frame = CGRect(x: textFieldWidth-41, y: (textFieldHeight/2)-12, width: 24, height: 24)
            self.addSubview(eyeBtn)
        }else{
            eyeBtn.frame = CGRect(x: 16, y: (textFieldHeight/2)-12, width: 24, height: 24)
            self.addSubview(eyeBtn)
        }
        eyeBtn.setBackgroundImage(UIImage(named: "visibility_off"), for: .normal)
    }
    
    @objc func eyeBtnTapped(){
        if isVisible == false {
            isVisible = true
            eyeBtn.setBackgroundImage(UIImage(named: "visibility"), for: .normal)
            self.isSecureTextEntry = false
        }else{
            isVisible = false
            eyeBtn.setBackgroundImage(UIImage(named: "visibility_off"), for: .normal)
            self.isSecureTextEntry = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
}

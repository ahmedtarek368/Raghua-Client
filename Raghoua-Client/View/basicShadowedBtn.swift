//
//  basicBlueShadowedBtn.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/28/21.
//

import UIKit

class basicShadowedBtn: UIButton {
    
    override func awakeFromNib(){
        super.awakeFromNib()
        isUnlockedButton()
    }
    
    func isLockedButton(){
        layer.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        layer.cornerRadius = 12
        layer.shadowRadius = 0
        layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        layer.shadowOpacity = 0
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func isUnlockedButton(){
        layer.shadowRadius = 9
        layer.shadowColor = #colorLiteral(red: 0.1411764706, green: 0.2274509804, blue: 0.5607843137, alpha: 1)
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.masksToBounds = false
        layer.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.2274509804, blue: 0.5607843137, alpha: 1)
        layer.cornerRadius = 12
    }
    
    func isCircleButton(){
        layer.cornerRadius = layer.frame.size.height/2
    }
    
    func isWhiteCircleButton(){
        layer.cornerRadius = layer.frame.size.height/2
        layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        layer.shadowRadius = 3
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0, height: 0)
    }

}

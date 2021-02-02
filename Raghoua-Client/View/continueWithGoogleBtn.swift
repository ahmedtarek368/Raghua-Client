//
//  continueWithGoogleBtn.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/28/21.
//

import UIKit

class continueWithGoogleBtn: UIButton {

    override func awakeFromNib(){
        super.awakeFromNib()
        customBtn()
    }
    
    func customBtn(){
        layer.shadowRadius = 4
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOpacity = 0.03
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.masksToBounds = false
        layer.cornerRadius = 12
        
        if "lang".localized == "en"{
            self.semanticContentAttribute = .forceLeftToRight
        }
    }

}

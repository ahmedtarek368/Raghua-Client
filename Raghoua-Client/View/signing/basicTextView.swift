//
//  basicTextView.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/1/21.
//

import UIKit

class basicTextView: UITextView {
    override func awakeFromNib(){
        super.awakeFromNib()
        customizeTextView()
    }

    func customizeTextView(){
        if "lang".localized == "en"{
            textAlignment = .left
        }else{
            textAlignment = .right
        }
    }
}

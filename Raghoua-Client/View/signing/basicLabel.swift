//
//  basicLabel.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/28/21.
//

import UIKit

class basicLabel: UILabel {

    override func awakeFromNib(){
        super.awakeFromNib()
        customizeLabel()
    }

    func customizeLabel(){
        if "lang".localized == "en"{
            textAlignment = .left
        }else{
            textAlignment = .right
        }
    }

}

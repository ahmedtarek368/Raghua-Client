//
//  customBottomPopupView.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/30/21.
//

import UIKit

class bottomPopupView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        cutomizeBottomPopupView()
    }
    
    func cutomizeBottomPopupView(){
        layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 25
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 8
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        layer.masksToBounds = false
    }
    
    func setBottomPopupHeight(height: Float){
        layer.bounds.size.height = CGFloat(height)
    }
    func setBottomPopupWidth(width: Float){
        layer.bounds.size.width = CGFloat(width)
    }

}

//
//  thanksBottomPopup.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit
import BottomPopup

class thanksBottomPopup: BottomPopupViewController, BottomPopupDelegate {

    override var popupShouldDismissInteractivelty: Bool{
        return false
    }
    override var popupHeight: CGFloat{
        return UIScreen.main.bounds.size.height/1.9
    }
    override var popupTopCornerRadius: CGFloat{
        return 25
    }
    override var popupPresentDuration: Double{
        return 0.3
    }
    override var popupDismissDuration: Double{
        return 0.3
    }
    override var popupDimmingViewAlpha: CGFloat{
        return 0.25
    }
    override var popupShouldBeganDismiss: Bool{
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func hideBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

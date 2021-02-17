//
//  successfulRegistrationVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/30/21.
//

import UIKit
import BottomPopup

class successfulRegistrationVC: BottomPopupViewController, BottomPopupDelegate {

    var delegate: dismissPopup?
    override var popupShouldDismissInteractivelty: Bool{
        return false
    }
    override var popupHeight: CGFloat{
        return UIScreen.main.bounds.size.height/2.2
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
        popupDelegate = self
    }

    func bottomPopupDidDismiss() {
        delegate?.didDismissPopup()
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
        
    }

}

//
//  purchaseWarningBottomPopupVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/13/21.
//

import UIKit
import BottomPopup

class purchaseWarningBottomPopupVC: BottomPopupViewController, BottomPopupDelegate {
    @IBOutlet weak var continueBtn: basicShadowedBtn!
    @IBOutlet weak var cancelBtn: basicShadowedBtn!
    
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
        cancelBtn.isLockedButton()
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.didDismissPopup()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

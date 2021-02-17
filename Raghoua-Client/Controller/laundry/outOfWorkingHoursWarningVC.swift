//
//  outOfWorkingHoursWarningVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/17/21.
//

import UIKit
import BottomPopup

class outOfWorkingHoursWarningVC: BottomPopupViewController, BottomPopupDelegate{

    override var popupShouldDismissInteractivelty: Bool{
        return false
    }
    override var popupHeight: CGFloat{
        return UIScreen.main.bounds.size.height
    }
    override var popupTopCornerRadius: CGFloat{
        return 110
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
        return true
    }
    @IBOutlet var popup: bottomPopupView!
    
    override func viewWillLayoutSubviews() {
        let screenSizeHeight : Float = Float(UIScreen.main.bounds.size.height)
        let screenSizeWidth : Float = Float(UIScreen.main.bounds.size.width)
        popup.setBottomPopupHeight(height: screenSizeHeight/3.8)
        popup.setBottomPopupWidth(width: screenSizeWidth/1.2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

}

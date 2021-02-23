//
//  sendMessageVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit

class sendMessageVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var name: basicTextField!
    @IBOutlet weak var email: basicTextField!
    @IBOutlet weak var messageType: basicTextField!
    @IBOutlet weak var messageContent: basicTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrow_back_\("lang".localized)"), for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        name.isUnderlinedTextField()
        email.isUnderlinedTextField()
        messageType.isUnderlinedTextField()
        messageContent.isUnderlinedTextField()
    }
    
    func popupThanksMessage(){
        if #available(iOS 13.0, *) {
            let popupThanksMessage : thanksBottomPopup = self.storyboard?.instantiateViewController(identifier: "TBP") as! thanksBottomPopup
            self.present(popupThanksMessage, animated: true, completion: nil)
        } else {
            let popupThanksMessage : thanksBottomPopup = self.storyboard?.instantiateViewController(withIdentifier: "TBP") as! thanksBottomPopup
            self.present(popupThanksMessage, animated: true, completion: nil)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendMessageBtnPressed(_ sender: Any) {
        popupThanksMessage()
    }
}

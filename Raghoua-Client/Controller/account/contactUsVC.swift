//
//  contactUsVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit

class contactUsVC: UIViewController {

    @IBOutlet weak var contactMobileNumber: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func pushToSendMessageVC(){
        if #available(iOS 13.0, *) {
            let sendMessageVC : sendMessageVC = self.storyboard?.instantiateViewController(identifier: "SMVC") as! sendMessageVC
            self.navigationController?.pushViewController(sendMessageVC, animated: true)
        } else {
            let sendMessageVC : sendMessageVC = self.storyboard?.instantiateViewController(withIdentifier: "SMVC") as! sendMessageVC
            self.navigationController?.pushViewController(sendMessageVC, animated: true)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func copyBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func callBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func sendEmailBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func sendMessageBtnPressed(_ sender: Any) {
        pushToSendMessageVC()
    }
    
}

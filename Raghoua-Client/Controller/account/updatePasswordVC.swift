//
//  updatePasswordVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit

class updatePasswordVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var oldPassword: passwordTextField!
    @IBOutlet weak var newPassword: passwordTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrow_back_\("lang".localized)"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPassword.isUnderlinedTextField()
        newPassword.isUnderlinedTextField()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveUpdateBtnPressed(_ sender: Any) {
        
    }
    
}

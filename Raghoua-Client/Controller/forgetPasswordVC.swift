//
//  forgetPasswordViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/28/21.
//

import UIKit

class forgetPasswordVC: UIViewController {

    @IBOutlet weak var mobileNumber: basicTextField!
    @IBOutlet weak var continueBtn: basicBlueShadowedBtn!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.hideKeyBoardWhenTappedAround()
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        let mobileNumberVerficationView = self.storyboard?.instantiateViewController(identifier: "MNVVC") as! restPassMobNumberVerifyVC
        self.navigationController?.pushViewController(mobileNumberVerficationView, animated: true)
    }
    
}

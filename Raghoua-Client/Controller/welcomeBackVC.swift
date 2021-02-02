//
//  welcomeBackViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/27/21.
//

import UIKit

class welcomeBackVC: UIViewController{

    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var emailOrMobileNumber: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var continueWithFacebookBtn: UIButton!
    @IBOutlet weak var continueWithGoogleBtn: UIButton!
    @IBOutlet weak var newRegisteration: UIButton!
    @IBOutlet weak var enterAsGuestBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alignViewBasedOnLanguage()
        makeRoundedCornerButtons()
        self.view.hideKeyBoardWhenTappedAround()
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func alignViewBasedOnLanguage(){
        if "lang".localized == "en"{
            continueWithFacebookBtn.semanticContentAttribute = .forceLeftToRight
        }
    }
    
    func makeRoundedCornerButtons(){
        continueWithFacebookBtn.makeRoundedCorners()
        enterAsGuestBtn.layer.cornerRadius = 20
    }
    
    @IBAction func forgetPasswordBtnPressed(_ sender: Any) {
        let forgetPasswordView : forgetPasswordVC  = self.storyboard?.instantiateViewController(identifier: "FPVC") as! forgetPasswordVC
        self.navigationController?.pushViewController(forgetPasswordView, animated: true)
    }
    @IBAction func registerBtnPressed(_ sender: Any) {
        let registerMobNumberVerifyView = self.storyboard?.instantiateViewController(identifier: "RMNVVC") as! registerMobNumberVC
        self.navigationController?.pushViewController(registerMobNumberVerifyView, animated: true)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        
    }
}

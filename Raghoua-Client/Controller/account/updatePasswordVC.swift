//
//  updatePasswordVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit
import Lottie

class updatePasswordVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var oldPassword: passwordTextField!
    @IBOutlet weak var newPassword: passwordTextField!
    
    var animationView: AnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrow_back_\("lang".localized)"), for: .normal)
        }
        setUpAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPassword.isUnderlinedTextField()
        newPassword.isUnderlinedTextField()
        self.view.hideKeyBoardWhenTappedAround()
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        animationView?.isHidden = true
        self.view.addSubview(animationView!)
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: popUpView(alert:)))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    
    func popUpView(alert: UIAlertAction){
        self.navigationController?.popViewController(animated: true)
    }
    
    func requestChangePassword(){
        let parameter = ["oldpassword":"\(oldPassword.text!)","newpassword":"\(newPassword.text!)"]
        NetworkService.shared.requestUpdateInfo(parameter: parameter) { (response) in
            self.animationView?.isHidden = true
            self.animationView?.stop()
            self.setupAlert(title: "success".localized, message: "password changed successfuly".localized)
        } onError: { (error) in
            self.animationView?.isHidden = true
            self.animationView?.stop()
            self.setupAlert(title: "fail".localized, message: "failed to change password".localized)
        }

    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveUpdateBtnPressed(_ sender: Any) {
        animationView?.play()
        animationView?.isHidden = false
        requestChangePassword()
    }
    
}

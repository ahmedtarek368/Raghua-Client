//
//  setNewPasswordViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit
import Lottie

class setNewPasswordVC: UIViewController {

    var animationView: AnimationView?
    var mobileNumber: String?
    
    @IBOutlet weak var password: passwordTextField!
    @IBOutlet weak var rewrittenPassword: passwordTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        self.view.hideKeyBoardWhenTappedAround()
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }

    @objc func backBtnPressed(){
        self.popBack(3)
    }
    
    @IBAction func resetPasswordBtnPressed(_ sender: Any) {
        animationView?.play()
        animationView?.isHidden = false
        requestResetPassword()
    }
    
    func requestResetPassword(){
        if password.text == rewrittenPassword.text {
            let parameters = [
                "phone":self.mobileNumber!,
                "newPassword":password.text!
            ]
            NetworkService.shared.requestResetPassword(param: parameters) { [self] (response) in
                animationView?.stop()
                animationView?.isHidden = true
                setupAlert(title: "success".localized, message: response.msg)
                self.popBack(3)
            } onError: { [self] (error) in
                animationView?.stop()
                animationView?.isHidden = true
                setupAlert(title: "fail".localized, message: error.msg)
            }
        }
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        successfulAlert.addAction(UIAlertAction(title: "Ok", style: .default , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    
}

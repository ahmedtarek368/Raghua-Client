//
//  forgetPasswordViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/28/21.
//

import UIKit
import Lottie

class forgetPasswordVC: UIViewController {

    var animationView: AnimationView?
    
    @IBOutlet weak var mobileNumber: basicTextField!
    @IBOutlet weak var continueBtn: basicBlueShadowedBtn!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        self.view.hideKeyBoardWhenTappedAround()
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        self.animationView?.play()
        self.animationView?.isHidden = false
        requestVerficationCode()
    }
    
    func requestVerficationCode(){
        let fullMobileNumber = mobileNumber.text!
        let param = ["type":"1","phone":fullMobileNumber]
        NetworkService.shared.requestVerficationCode(param: param) { (response) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            self.pushToMobileNumberVerifyView(code: response.code)
            self.setupAlert(title: "success".localized, message: "\(response.msg)\nyour code is:\(response.code) ")
        } onError: { (error) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            self.setupAlert(title: "fail".localized, message: error)
        }
    }
    
    func pushToMobileNumberVerifyView(code: Int){
        let mobileNumberVerifyView = self.storyboard?.instantiateViewController(identifier: "MNVVC") as! restPassMobNumberVerifyVC
        mobileNumberVerifyView.verificationCode = code
        mobileNumberVerifyView.mobileNumber = self.mobileNumber.text
        self.navigationController?.pushViewController(mobileNumberVerifyView, animated: true)
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        successfulAlert.addAction(UIAlertAction(title: "Ok", style: .default , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    
}

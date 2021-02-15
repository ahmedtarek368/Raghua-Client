//
//  registerMobNumberVerifyVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit
import Lottie

@available(iOS 13.0, *)
class registerMobNumberVC: UIViewController {

    var animationView: AnimationView?
    
    @IBOutlet weak var ourLbl: UILabel!
    @IBOutlet weak var termOfUserBtn: UIButton!
    @IBOutlet weak var mobileNumber: regionedMobileNumberTF!
    let regionCode = UITextField()
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        if "lang".localized == "en"{
            ourLbl.isHidden = true
        }
        regionCode.delegate = self
        mobileNumber.addRegionCodeField(codeField: regionCode)
        self.view.hideKeyBoardWhenTappedAround()
        termOfUserBtn.makeUnderLinedString()
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        view.addSubview(animationView!)
        animationView?.play()
        animationView?.isHidden = false
        let fullMobileNumber = "\(regionCode.text!)\(mobileNumber.text!)"
        let param = ["type":"0","phone":fullMobileNumber]
        NetworkService.shared.requestVerficationCode(param: param) { (response) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            self.pushToVerifyRegisteredMobNumberView(code: response.code)
            self.setupAlert(title: "success".localized, message: "\(response.msg)\nyour code is:\(response.code) ")
        } onError: { (error) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            self.setupAlert(title: "fail".localized, message: error)
        }
    }
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    func pushToVerifyRegisteredMobNumberView(code: Int) {
        let verifyRegisteredMobNumberView : verifyRegisteredMobNumberVC = self.storyboard?.instantiateViewController(identifier: "VRMNVC") as! verifyRegisteredMobNumberVC
        verifyRegisteredMobNumberView.mobileNumber = self.mobileNumber.text
        verifyRegisteredMobNumberView.verificationCode = code
        self.navigationController?.pushViewController(verifyRegisteredMobNumberView, animated: true)
    }
    
}

@available(iOS 13.0, *)
extension registerMobNumberVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}

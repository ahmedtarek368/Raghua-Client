//
//  updateUserNameVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit
import Lottie

class updateUserNameVC: UIViewController {


    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userName: basicTextField!
    
    var delegate: updateUserInfo?
    var animationView: AnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrow_back_\("lang".localized)"), for: .normal)
        }
        setUpAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.isUnderlinedTextField()
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
    
    func requestUpdateUserName(){
        if userName.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""{
            let parameter = ["name":"\(userName.text!)"]
            NetworkService.shared.requestUpdateInfo(parameter: parameter) { (response) in
                let userData : userData = response.user
                userToken = userData.apiToken
                let user : User = User(id: userData.id, name: userData.name, email: userData.email, phone: userData.phone, img: userData.img, apiToken: userData.apiToken, points: userData.points, cartID: userData.cartID ?? 0, userAddress: userData.userAddress)
                self.animationView?.isHidden = true
                self.animationView?.stop()
                self.delegate!.updateUserInfo(user: user)
                self.setupAlert(title: "success".localized, message: "name changed successfuly".localized)
            } onError: { (error) in
                self.animationView?.isHidden = true
                self.animationView?.stop()
                debugPrint(error)
            }
        }else{
            setupAlert(title: "fail".localized, message: "nameWarning".localized)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveUpdateBtnPressed(_ sender: Any) {
        animationView?.play()
        animationView?.isHidden = false
        requestUpdateUserName()
    }
    

}

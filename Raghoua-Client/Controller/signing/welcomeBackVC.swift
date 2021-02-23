//
//  welcomeBackViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/27/21.
//

import UIKit
import Lottie

class welcomeBackVC: UIViewController{
    
    var animationView: AnimationView?

    @IBOutlet weak var welcomeBackLabel: UILabel!
    @IBOutlet weak var emailOrMobileNumber: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var forgetPasswordBtn: UIButton!
    @IBOutlet weak var continueWithFacebookBtn: UIButton!
    @IBOutlet weak var continueWithGoogleBtn: UIButton!
    @IBOutlet weak var newRegisteration: UIButton!
    @IBOutlet weak var enterAsGuestBtn: UIButton!
    
    var user : User?
    
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
        setUpAnimation()
        alignViewBasedOnLanguage()
        makeRoundedCornerButtons()
        self.view.hideKeyBoardWhenTappedAround()
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LGN"{
            let homeTabBar = segue.destination as! UITabBarController
            let laundriesNav = homeTabBar.viewControllers?.first as! UINavigationController
            let laundriesVC = laundriesNav.viewControllers.first as! laundriesVC
            if let user = self.user{
                laundriesVC.initUserData(user: user)
                laundriesVC.addressIndex = 0
            }
        }
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
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
        if #available(iOS 13.0, *) {
            let forgetPasswordView : forgetPasswordVC  = self.storyboard?.instantiateViewController(identifier: "FPVC") as! forgetPasswordVC
            self.navigationController?.pushViewController(forgetPasswordView, animated: true)
        } else {
            let forgetPasswordView : forgetPasswordVC  = self.storyboard?.instantiateViewController(withIdentifier: "FPVC") as! forgetPasswordVC
            self.navigationController?.pushViewController(forgetPasswordView, animated: true)
        }
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let registerMobNumberVerifyView = self.storyboard?.instantiateViewController(identifier: "RMNVVC") as! registerMobNumberVC
            self.navigationController?.pushViewController(registerMobNumberVerifyView, animated: true)
        } else {
            let registerMobNumberVerifyView = self.storyboard?.instantiateViewController(withIdentifier: "RMNVVC") as! registerMobNumberVC
            self.navigationController?.pushViewController(registerMobNumberVerifyView, animated: true)
        }
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        view.addSubview(animationView!)
        animationView?.isHidden = false
        animationView?.play()
        requestUserLogin()
    }
    
    @IBAction func continueAsGuestBtnPressed(_ sender: Any) {
        pushToHome()
    }
    
    func requestUserLogin(){
        if let emailOrMobileNumber = emailOrMobileNumber.text, let password = password.text {
            
            let loginParam = LoginParam(user_info:emailOrMobileNumber,password:password)
            NetworkService.shared.requestUserLogin(param: loginParam) { (response) in
                
                let userData : userData = response.data
                userToken = userData.apiToken
                let user : User = User(id: userData.id, name: userData.name, email: userData.email, phone: userData.phone, img: userData.img, apiToken: userData.apiToken, points: userData.points, cartID: userData.cartID ?? 0, userAddress: userData.userAddress)
                self.user = user
                // userEmail -> UserDefaults.standard.setValue(emailOrMobileNumber, forKey: "EmailOrPhone")
                // userPassword -> UserDefaults.standard.setValue(password, forKey: "Password")
                self.performSegue(withIdentifier: "LGN", sender: self)
                self.animationView?.stop()
                self.animationView?.isHidden = true
            } onError: { (error) in
                self.animationView?.stop()
                self.animationView?.isHidden = true
                self.setupAlert(title:"fail".localized, message: "\(error)")
                print(error)
            }
            
        }
    }
    
    func pushToHome(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if #available(iOS 13.0, *) {
            let tabBarHomeView : UITabBarController = self.storyboard?.instantiateViewController(identifier: "TBH") as! UITabBarController
            self.navigationController?.pushViewController(tabBarHomeView, animated: true)
        } else {
            let tabBarHomeView : UITabBarController = self.storyboard?.instantiateViewController(withIdentifier: "TBH") as! UITabBarController
            self.navigationController?.pushViewController(tabBarHomeView, animated: true)
        }
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
}

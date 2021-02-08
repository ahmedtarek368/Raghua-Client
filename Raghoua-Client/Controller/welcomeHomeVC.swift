//
//  welcomeHomeViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/27/21.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Lottie

class welcomeHomeVC: UIViewController {

    var animationView: AnimationView?
    
    var socialUser: User = User()
    var provider: String?
    var userSocialID: String?
    @IBOutlet weak var continueWithFacebookBtn: UIButton!
    @IBOutlet weak var continueWithGoogleBtn: UIButton!
    @IBOutlet weak var enterAsGuestBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        alignViewBasedOnLanguage()
        makeRoundedCornerButtons()
        if let token = AccessToken.current, !token.isExpired{
            self.userSocialID = token.userID
            self.provider = "facebook"
            requestUserProfileData(token: token.tokenString)
        }else{
            //Check User Defaults for userName and Email
        }
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        let welcomeBackView : welcomeBackVC = self.storyboard?.instantiateViewController(identifier: "WBVC") as! welcomeBackVC
        self.navigationController?.pushViewController(welcomeBackView, animated: true)
    }
    
    func alignViewBasedOnLanguage(){
        if "lang".localized == "en"{
            continueWithFacebookBtn.semanticContentAttribute = .forceLeftToRight
        }
    }
    
    func makeRoundedCornerButtons(){
        enterAsGuestBtn.layer.cornerRadius = 20
        continueWithFacebookBtn.makeRoundedCorners()
    }
    
    func requestFacebookLogin(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result {
            case .success(granted: _, declined: _, token: let accessToken):
                let token = accessToken?.tokenString
                self.userSocialID =  accessToken?.userID
                self.provider = "facebook"
                self.requestUserProfileData(token: token!)
                break
            case .failed(let error):
                self.animationView?.stop()
                self.animationView?.isHidden = true
                debugPrint(error.localizedDescription)
                break
            case .cancelled:
                self.animationView?.stop()
                self.animationView?.isHidden = true
                break
            }
        }
    }
    
    func requestUserProfileData(token: String){
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name, picture.type(large)"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                self.animationView?.stop()
                self.animationView?.isHidden = true
            }else{
                print("\(result!)")
                let userData: [String:Any] = result as! [String : Any]
                let name = userData["name"] as! String
                let email = userData["email"] as! String
                //let id = userData["id"] as! Int
                //let picture: [String:Any] = userData["picture"] as! [String : Any]
                //let picData: [String:Any] = picture["data"] as! [String:Any]
                //let picURL = picData["url"] as! String
                self.saveUserSocialData(email: email, name: name)
            }
        }
    }
    
    func saveUserSocialData(email :String, name: String){
        let parameters = [
            "name":name,
            "email":email,
            "provider":self.provider!,
            "provider_id":self.userSocialID!
        ]
        print(parameters)
        NetworkService.shared.saveUserSocialData(param: parameters) { (response) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            print(response)
            let userData = response.data
            self.socialUser = User(id: userData.id, name: userData.name, email: userData.email, phone: userData.phone, img: userData.img, apiToken: userData.apiToken, points: userData.points, cartID: userData.cartID ?? 0, userAddress: userData.userAddress)
        } onError: { (error) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            debugPrint(error)
        }

    }

    @IBAction func continueWithFacebookBtnPressed(_ sender: Any) {
        animationView?.play()
        animationView?.isHidden = false
        requestFacebookLogin()
    }
    
    @IBAction func continueWithGoogleBtnPressed(_ sender: Any) {
        
    }
    
}


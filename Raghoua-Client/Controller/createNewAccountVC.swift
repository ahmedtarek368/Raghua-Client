//
//  createNewAccountVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit
import BottomPopup
import Lottie

@available(iOS 13.0, *)
class createNewAccountVC: UIViewController {

    var user = User()
    var pickedImage: UIImage?
    var animationView: AnimationView?
    var mobileNumber: String?
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var pickImageBtn: UIButton!
    @IBOutlet weak var userName: basicTextField!
    @IBOutlet weak var userEmail: basicTextField!
    @IBOutlet weak var userPassword: passwordTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimation()
        makeRoundedCorners()
        self.view.hideKeyBoardWhenTappedAround()
    }

    @objc func backBtnPressed(){
        self.popBack(3)
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    func makeRoundedCorners(){
        userProfileImage.layer.cornerRadius = userProfileImage.frame.size.height/2
        pickImageBtn.layer.cornerRadius = pickImageBtn.frame.size.height/2
    }
    
    @IBAction func pickImageBtnPressed(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        view.addSubview(animationView!)
        animationView?.play()
        animationView?.isHidden = false
        requestUserSignup()
    }
    
    func requestUserSignup(){
        if let userName = userName.text, let userEmail = userEmail.text, let userPassword = userPassword.text{
            let parameters :[String:String] = [
                "type" : "0",
                "name" : userName,
                "email" : userEmail,
                "phone" : mobileNumber!,
                "password" : userPassword,
            ]
            
            if let image: UIImage = pickedImage {
                NetworkService.shared.requestUserSignup(param: parameters, image: image) { (response) in
                    self.animationView?.stop()
                    self.animationView?.isHidden = true
                    self.presentBottomPopup()
                    print(response)
                    let userData = response.data
                    userToken = userData.apiToken
                    self.user = User(id: userData.id, name: userData.name, email: userData.email, phone: userData.phone, img: userData.img, apiToken: userData.apiToken, points: userData.points, cartID: userData.cartID ?? 0, userAddress: userData.userAddress)
                    self.setupAlert(title: "success".localized, message: "\(userData.name)")
                } onError: { (error) in
                    self.animationView?.stop()
                    self.animationView?.isHidden = true
                    self.setupAlert(title: "fail".localized, message: "\(error)")
                }
            }else{
                self.animationView?.stop()
                self.animationView?.isHidden = true
                setupAlert(title: "fail", message: "You Must Pick Image".localized)
            }
        }
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    
    func presentBottomPopup(){
        let bottomPopupView : successfulRegistrationVC = self.storyboard?.instantiateViewController(identifier: "SRVC") as! successfulRegistrationVC
        bottomPopupView.delegate = self
        self.present(bottomPopupView, animated: true, completion: nil)
    }
    
}

@available(iOS 13.0, *)
extension createNewAccountVC: dismissPopup{
    func didDismissPopup() {
        let howDidYouKnowAboutUs : howDidYouKnowAboutUsVC = self.storyboard?.instantiateViewController(identifier: "HDYKAUVC") as! howDidYouKnowAboutUsVC
        howDidYouKnowAboutUs.user = self.user
        self.navigationController?.pushViewController(howDidYouKnowAboutUs, animated: true)
    }
}

@available(iOS 13.0, *)
extension createNewAccountVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func showImagePickerControllerActionSheet(){
        let imageSourceAlert = UIAlertController(title: "Choose your image", message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Choose from library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let cameraAction = UIAlertAction(title: "Choose from camera", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        imageSourceAlert.addAction(photoLibraryAction)
        imageSourceAlert.addAction(cameraAction)
        self.present(imageSourceAlert, animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            pickedImage = editedImage
            userProfileImage.image = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            pickedImage = originalImage
            userProfileImage.image = originalImage
        }
        
    }
}

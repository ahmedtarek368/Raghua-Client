//
//  createNewAccountVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit
import BottomPopup

class createNewAccountVC: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var selectImageBtn: UIButton!
    @IBOutlet weak var userName: basicTextField!
    @IBOutlet weak var userEmail: basicTextField!
    @IBOutlet weak var userPassword: passwordTextField!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRoundedCorners()
        self.view.hideKeyBoardWhenTappedAround()
        
    }

    @objc func backBtnPressed(){
        self.popBack(3)
    }
    
    func makeRoundedCorners(){
        userImage.layer.cornerRadius = userImage.frame.size.height/2
        selectImageBtn.layer.cornerRadius = selectImageBtn.frame.size.height/2
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        let bottomPopupView : successfulRegistrationVC = self.storyboard?.instantiateViewController(identifier: "SRVC") as! successfulRegistrationVC
        bottomPopupView.delegate = self
        self.present(bottomPopupView, animated: true, completion: nil)
    }
    
}

extension createNewAccountVC: dismissPopup{
    func didDismissPopup() {
        let howDidYouKnowAboutUs : howDidYouKnowAboutUsVC = self.storyboard?.instantiateViewController(identifier: "HDYKAUVC") as! howDidYouKnowAboutUsVC
        self.navigationController?.pushViewController(howDidYouKnowAboutUs, animated: true)
    }
}

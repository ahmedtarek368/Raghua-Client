//
//  updateInfoVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit

class updateInfoVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var userMobileNumber: basicLabel!
    @IBOutlet weak var userEmail: basicLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func pushToEditUserName(){
        if #available(iOS 13.0, *) {
            let updateUserNameView : updateUserNameVC = self.storyboard?.instantiateViewController(identifier: "UUNVC") as! updateUserNameVC
            self.navigationController?.pushViewController(updateUserNameView, animated: true)
        } else {
            let updateUserNameView : updateUserNameVC = self.storyboard?.instantiateViewController(withIdentifier: "UUNVC") as! updateUserNameVC
            self.navigationController?.pushViewController(updateUserNameView, animated: true)
        }
    }
    
    func pushToUpdatePassword(){
        if #available(iOS 13.0, *) {
            let updatePasswordView : updatePasswordVC = self.storyboard?.instantiateViewController(identifier: "UPVC") as! updatePasswordVC
            self.navigationController?.pushViewController(updatePasswordView, animated: true)
        } else {
            let updatePasswordView : updatePasswordVC = self.storyboard?.instantiateViewController(withIdentifier: "UPVC") as! updatePasswordVC
            self.navigationController?.pushViewController(updatePasswordView, animated: true)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func downloadImageBtnPressed(_ sender: Any) {
    }
    
    @IBAction func editUserNameBtnPressed(_ sender: Any) {
        pushToEditUserName()
    }
    
    @IBAction func updatePasswordBtnPressed(_ sender: Any) {
        pushToUpdatePassword()
    }
    
}

//
//  mobileNumberVerficationViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/28/21.
//

import UIKit

class restPassMobNumberVerifyVC: UIViewController {

    @IBOutlet weak var firstDigit: UITextField!
    @IBOutlet weak var secondDigit: UITextField!
    @IBOutlet weak var thirdDigit: UITextField!
    @IBOutlet weak var fourthDigit: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstDigit.delegate = self
        secondDigit.delegate = self
        thirdDigit.delegate = self
        fourthDigit.delegate = self
        self.view.hideKeyBoardWhenTappedAround()
        
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func pushToSetNewPasswordView(){
        let setNewPasswordView : setNewPasswordVC = self.storyboard?.instantiateViewController(identifier: "SNPVC") as! setNewPasswordVC
        self.navigationController?.pushViewController(setNewPasswordView, animated: true)
    }
    
}

extension restPassMobNumberVerifyVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let textFieldCount = textField.text?.count else { return false }

            // Сlosure
            let setValueAndMoveForward = {
                textField.text = string
                let nextTag = textField.tag + 1
                if let nextResponder = textField.superview?.viewWithTag(nextTag) {
                    nextResponder.becomeFirstResponder()
                }
            }

            // Сlosure
            let clearValueAndMoveBack = {
                textField.text = ""
                let previousTag = textField.tag - 1
                if let previousResponder = textField.superview?.viewWithTag(previousTag) {
                    previousResponder.becomeFirstResponder()
                }
            }

            if textFieldCount < 1 && string.count > 0 {

                setValueAndMoveForward()

                if textField.tag == 4 {
                    pushToSetNewPasswordView()
                }

                return false

            } else if textFieldCount >= 1 && string.count == 0 {

                clearValueAndMoveBack()
                return false

            } else if textFieldCount >= 1 && string.count > 0 {

                let nextTag = textField.tag + 1
                if let previousResponder = textField.superview?.viewWithTag(nextTag) {
                    previousResponder.becomeFirstResponder()

                    if let activeTextField = previousResponder as? UITextField {
                        activeTextField.text = string
                    }
                }

                return false
            }

            return true

        }
    
}

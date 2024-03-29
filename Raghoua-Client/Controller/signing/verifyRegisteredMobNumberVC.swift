//
//  verifyRegisteredMobNumberVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit

class verifyRegisteredMobNumberVC: UIViewController {
    
    var verificationCode:Int?
    var mobileNumber:String?
    
    @IBOutlet weak var firstDigit: UITextField!
    @IBOutlet weak var secondDigit: UITextField!
    @IBOutlet weak var thirdDigit: UITextField!
    @IBOutlet weak var fourthDigit: UITextField!
    @IBOutlet weak var digitsStack: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
        digitsStack.semanticContentAttribute = .forceLeftToRight
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
    
    func pushToCreateNewAccountVC(){
        if #available(iOS 13.0, *) {
            let createNewAccountVC : createNewAccountVC = self.storyboard?.instantiateViewController(identifier: "CNAVC") as! createNewAccountVC
            createNewAccountVC.mobileNumber = self.mobileNumber
            self.navigationController?.pushViewController(createNewAccountVC, animated: true)
        } else {
            let createNewAccountVC : createNewAccountVC = self.storyboard?.instantiateViewController(withIdentifier: "CNAVC") as! createNewAccountVC
            createNewAccountVC.mobileNumber = self.mobileNumber
            self.navigationController?.pushViewController(createNewAccountVC, animated: true)
        }
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        successfulAlert.addAction(UIAlertAction(title: "Ok", style: .default , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }

}

extension verifyRegisteredMobNumberVC: UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let textFieldCount = textField.text?.count else { return false }

            // Сlosure
            let setValueAndMoveForward = {
                textField.text = string
                
                let nextTag = textField.tag + 1
                print("add\(nextTag)")
                if let nextResponder = textField.superview?.viewWithTag(nextTag) {
                    nextResponder.becomeFirstResponder()
                }
            }

            // Сlosure
            let clearValueAndMoveBack = {
                textField.text = ""
                
                let previousTag = textField.tag - 1
                print("clear\(previousTag)")
                if let previousResponder = textField.superview?.viewWithTag(previousTag) {
                    previousResponder.becomeFirstResponder()
                }
            }

            if textFieldCount < 1 && string.count > 0 {

                setValueAndMoveForward()

                if textField.tag == 4 {
                    if firstDigit.text != nil && secondDigit.text != nil && thirdDigit.text != nil && fourthDigit.text != nil {
                        let userEnteredCode = "\(firstDigit.text!)\(secondDigit.text!)\(thirdDigit.text!)\(fourthDigit.text!)"
                        print(userEnteredCode)
                        if String(self.verificationCode!) == userEnteredCode {
                            pushToCreateNewAccountVC()
                        }else{
                            self.setupAlert(title:"failed",message:"Wrong Verfication Code")
                        }
                    }else{
                        self.setupAlert(title:"failed",message:"Code is Missing Digit")
                    }
                }

                return false

            } else if textFieldCount >= 1 && string.count == 0 {

                clearValueAndMoveBack()
                print("==")
                return false

            } else if textFieldCount >= 1 && string.count > 0 {
                
                let nextTag = textField.tag + 1
                print(">=\(nextTag)")
                
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

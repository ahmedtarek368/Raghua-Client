//
//  registerMobNumberVerifyVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit

class registerMobNumberVC: UIViewController {

    @IBOutlet weak var ourLbl: UILabel!
    @IBOutlet weak var termOfUserBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if "lang".localized == "en"{
            ourLbl.isHidden = true
        }
        let attributes = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underLineAttributedString = NSAttributedString(string: termOfUserBtn.currentTitle!, attributes: attributes)
        termOfUserBtn.titleLabel?.attributedText = underLineAttributedString
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func continueBtnPressed(_ sender: Any) {
        let verifyRegisteredMobNumberView : verifyRegisteredMobNumberVC = self.storyboard?.instantiateViewController(identifier: "VRMNVC") as! verifyRegisteredMobNumberVC
        self.navigationController?.pushViewController(verifyRegisteredMobNumberView, animated: true)
    }
    
}

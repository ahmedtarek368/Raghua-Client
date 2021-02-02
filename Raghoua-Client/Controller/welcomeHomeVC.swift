//
//  welcomeHomeViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/27/21.
//

import UIKit

class welcomeHomeVC: UIViewController {

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
        alignViewBasedOnLanguage()
        makeRoundedCornerButtons()
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

}


//
//  setNewPasswordViewController.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/29/21.
//

import UIKit

class setNewPasswordVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.hideKeyBoardWhenTappedAround()
    }

    @objc func backBtnPressed(){
        self.popBack(3)
    }
    
}

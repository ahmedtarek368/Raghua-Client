//
//  addAddressVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/1/21.
//

import UIKit

class addAddressVC: UIViewController {

    
    @IBOutlet weak var streetField: basicTextField!
    @IBOutlet weak var buildingField: basicTextField!
    @IBOutlet weak var floorField: basicTextField!
    @IBOutlet weak var apartmentField: basicTextField!
    @IBOutlet weak var nearestLandmarkField: basicTextField!
    @IBOutlet weak var addressType: basicTextField!
    
    override func viewDidLayoutSubviews() {
        streetField.isUnderlinedTextField()
        buildingField.isUnderlinedTextField()
        floorField.isUnderlinedTextField()
        apartmentField.isUnderlinedTextField()
        nearestLandmarkField.isUnderlinedTextField()
        addressType.isUnderlinedTextField()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.hideKeyBoardWhenTappedAround()
    }
 
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }

}

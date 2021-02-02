//
//  addressesListVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/31/21.
//

import UIKit

class addressesListVC: UIViewController {

    @IBOutlet weak var addressesListTV: UITableView!
    @IBOutlet weak var continueBtn: basicBlueShadowedBtn!
    @IBOutlet weak var addAddressBtn: basicBlueShadowedBtn!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressesListTV.delegate = self
        addressesListTV.dataSource = self
        addressesListTV.tableFooterView =  UIView()
        continueBtn.isLockedButton()
        addAddressBtn.isCircleButton()
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        
    }
    @IBAction func addAddressBtnPressed(_ sender: Any) {
//        let addAddressView : addAddressVC = self.storyboard?.instantiateViewController(identifier: "AAVC") as! addAddressVC
//        self.navigationController?.pushViewController(addAddressView, animated: true)
        let spotYourLocationView : spotYourLocationVC = self.storyboard?.instantiateViewController(identifier: "SYLVC") as! spotYourLocationVC
        self.navigationController?.pushViewController(spotYourLocationView, animated: true)
    }
    
    
}


extension addressesListVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ADC", for: indexPath) as! addressCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : addressCell = tableView.cellForRow(at: indexPath) as! addressCell
        cell.setSelected(true, animated: true)
        continueBtn.isUnlockedButton()
        continueBtn.isUserInteractionEnabled = true
    }
    
}

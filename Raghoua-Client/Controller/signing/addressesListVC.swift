//
//  addressesListVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/31/21.
//

import UIKit

class addressesListVC: UIViewController {

    var userAddresses: [Address] = [Address]()
    var user: User?
    var addressIndex: Int = 0
    @IBOutlet weak var addressesListTV: UITableView!
    @IBOutlet weak var continueBtn: basicShadowedBtn!
    @IBOutlet weak var addAddressBtn: basicShadowedBtn!
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
        getUserAddresses()
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
        //userName userDefaults
        //userMail userDefaults
        //userAddressindex userDefaults
        //Enter App
        performSegue(withIdentifier: "SGN", sender: self)
    }
    
    @IBAction func addAddressBtnPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let spotYourLocationView : spotYourLocationVC = self.storyboard?.instantiateViewController(identifier: "SYLVC") as! spotYourLocationVC
            self.navigationController?.pushViewController(spotYourLocationView, animated: true)
        } else {
            let spotYourLocationView : spotYourLocationVC = self.storyboard?.instantiateViewController(withIdentifier: "SYLVC") as! spotYourLocationVC
            self.navigationController?.pushViewController(spotYourLocationView, animated: true)
        }
    }
    
    func getUserAddresses(){
        NetworkService.shared.requestGetUserAddresses { (response) in
            let addressesData = response.data
            self.user?.setAddresses(addresses: addressesData)
            for i in 0..<addressesData.count{
                let addressData = Address(latitude: addressesData[i].lat, longitude: addressesData[i].long, address: addressesData[i].address, street: addressesData[i].street, realStateNumber: addressesData[i].realstateNumber, floorNumber: addressesData[i].floorNumber, apartmentNumber: addressesData[i].departNumber, nearestPlace: addressesData[i].nearstPlace, addressType: addressesData[i].addressType)
                self.userAddresses.append(addressData)
            }
            self.addressesListTV.reloadData()
            
        } onError: { (error) in
            debugPrint(error)
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SGN"{
            let homeTabBar = segue.destination as! UITabBarController
            let laundriesNav = homeTabBar.viewControllers?.first as! UINavigationController
            let laundriesVC = laundriesNav.viewControllers.first as! laundriesVC
            if let user = self.user{
                laundriesVC.initUserData(user: user)
                laundriesVC.addressIndex = self.addressIndex
            }
        }
    }
    
}


extension addressesListVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userAddresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ADC", for: indexPath) as! addressCell
        let address = userAddresses[indexPath.row]
        cell.updateCell(address:address)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : addressCell = tableView.cellForRow(at: indexPath) as! addressCell
        self.addressIndex = indexPath.row
        cell.setSelected(true, animated: true)
        continueBtn.isUnlockedButton()
        continueBtn.isUserInteractionEnabled = true
    }
    
}

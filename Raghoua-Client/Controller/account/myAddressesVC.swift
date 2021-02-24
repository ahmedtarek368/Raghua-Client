//
//  myAddressesVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit
import Lottie

class myAddressesVC: UIViewController {

    @IBOutlet weak var myAddressesTV: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var addAddressBtn: basicShadowedBtn!
    
    var animationView: AnimationView?
    var userAddresses: [addressesData]?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
        addAddressBtn.isCircleButton()
        setUpAnimation()
        getUserAddresses()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAddressesTV.delegate = self
        myAddressesTV.dataSource = self
        myAddressesTV.tableFooterView = UIView()
    }
    
    func getUserAddresses(){
        animationView?.play()
        animationView?.isHidden = false
        NetworkService.shared.requestGetUserAddresses { (response) in
            self.userAddresses = response.data
            self.animationView?.isHidden = false
            self.animationView?.stop()
            self.myAddressesTV.reloadData()
        } onError: { (error) in
            self.animationView?.isHidden = false
            self.animationView?.stop()
            debugPrint(error)
        }
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        animationView?.isHidden = true
        self.view.addSubview(animationView!)
    }

    @IBAction func addAddressBtnPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13.0, *) {
            let spotYourLocationView : spotYourLocationVC = storyboard.instantiateViewController(identifier: "SYLVC") as! spotYourLocationVC
            self.navigationController?.pushViewController(spotYourLocationView, animated: true)
        } else {
            let spotYourLocationView : spotYourLocationVC = storyboard.instantiateViewController(withIdentifier: "SYLVC") as! spotYourLocationVC
            self.navigationController?.pushViewController(spotYourLocationView, animated: true)
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension myAddressesVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let userAddresses = self.userAddresses{
            return userAddresses.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addressCell : myAddresseCell = tableView.dequeueReusableCell(withIdentifier: "MADC", for: indexPath) as! myAddresseCell
        let address = self.userAddresses![indexPath.row]
        addressCell.updateCell(address: address)
        return addressCell
    }
    
}

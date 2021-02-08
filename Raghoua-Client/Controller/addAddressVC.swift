//
//  addAddressVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/1/21.
//

import UIKit
import Lottie

class addAddressVC: UIViewController {

    var animationView: AnimationView?
    var userLocationOnMap: String?
    var latitude: Double?
    var longitude: Double?
    
    @IBOutlet weak var locationOnMap: basicTextView!
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
        initUserLocationOnMap()
        setUpAnimation()
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    func initUserLocationOnMap(){
        self.locationOnMap.text = userLocationOnMap
    }
 
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        animationView?.play()
        animationView?.isHidden = false
        requestAddUserAddress()
    }
    
    func requestAddUserAddress(){
        let parameters :[String:String] = [
            "lat" : String(latitude!),
            "long" : String(longitude!),
            "address" : userLocationOnMap!,
            "street" : streetField.text!,
            "realstate_number" : "0",
            "floor_number" : floorField.text!,
            "depart_number": apartmentField.text!,
            "nearst_place":nearestLandmarkField.text!,
            "plcae_type" : addressType.text!
        ]
        NetworkService.shared.requestAddUserAddress(param: parameters) { (response) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            self.popBack(3)
            self.setupAlert(title: "success", message: response.msg)
        } onError: { (error) in
            self.animationView?.stop()
            self.animationView?.isHidden = true
            self.setupAlert(title: "fail", message: error.msg)
        }
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    

}

//
//  laundriesVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/6/21.
//

import UIKit
import Lottie

class laundriesVC: UIViewController {

    @IBOutlet weak var laundriesTVC: UITableView!
    @IBOutlet weak var reorderBtn: basicShadowedBtn!
    @IBOutlet weak var laundriesCount: UILabel!
    
    var user : User?
    var addressIndex : Int?
    var laundriesData : [Laundry]?
    var animationView: AnimationView?
    var guestFlag : Bool = false
    var longitude: String?
    var latitude : String?
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: 7)
        self.tabBarController?.tabBar.layer.shadowRadius = 9
        self.tabBarController?.tabBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.tabBarController?.tabBar.layer.shadowOpacity = 0.2
        self.tabBarController?.tabBar.layer.masksToBounds = false
        self.tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laundriesTVC.delegate = self
        laundriesTVC.dataSource = self
        reorderBtn.isCircleButton()
        setUpAnimation()
        prepareRequestLaundries()
        laundriesTVC.tableFooterView = UIView()
        if let user = self.user{
            print(user.userAddress!)
        }
    }
    
    //will pass address index
    func initUserData(user:User){
        self.user = user
    }
    
    func prepareRequestLaundries(){
        view.addSubview(animationView!)
        animationView?.isHidden = false
        animationView?.play()
        if guestFlag == false{
            guard let index = self.addressIndex else{return}
            let userAddress = user?.userAddress[index]
            let parameter = [
                "lat":"\(userAddress!.lat)",
                "long":"\(userAddress!.long)"
            ]
            requestLaundries(parameter: parameter)
        }else{
            let parameter = [
                "lat":"\(self.latitude!)",
                "long":"\(self.longitude!)"
            ]
            requestLaundries(parameter: parameter)
        }
    }
    
    func requestLaundries(parameter: [String:String]){
        NetworkService.shared.requestLaundries(param: parameter) { (response) in
            let laundriesData = response.dataa.data
            self.laundriesCount.text = "\(laundriesData.count) مغسلة"
            self.laundriesData = laundriesData
            self.laundriesTVC.reloadData()
            self.animationView?.isHidden = true
            self.animationView?.stop()
            //self.setupAlert(title: "success".localized, message: response.msg)
        } onError: { (error) in
            self.animationView?.isHidden = true
            self.animationView?.stop()
            self.setupAlert(title: "fail".localized, message: error)
        }
    }
    
    func setUpAnimation(){
        animationView = .init(name: "Loading Animation")
        animationView?.loopMode = .loop
        animationView?.frame.size.height = view.frame.size.height/3.5
        animationView?.frame.size.width = view.frame.size.width/3.5
        animationView?.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    func setupSignupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            successfulAlert.addAction(UIAlertAction(title: "Signup", style: .default , handler: transitionToHome(alert:)))
            successfulAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    
    func transitionToHome(alert: UIAlertAction) {
        self.performSegue(withIdentifier: "GH", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GH"{
            let _ = segue.destination as! UINavigationController
        }
    }
    
    @IBAction func reorderBtnPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let reorderingLaundriesPopup : reorderingLaundriesPopupVC = self.storyboard?.instantiateViewController(identifier: "RLPVC") as! reorderingLaundriesPopupVC
            self.present(reorderingLaundriesPopup, animated: true)
        } else {
            let reorderingLaundriesPopup : reorderingLaundriesPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "RLPVC") as! reorderingLaundriesPopupVC
            self.present(reorderingLaundriesPopup, animated: true)
        }
    }
    
}

extension laundriesVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let laundriesData = self.laundriesData{
            return laundriesData.count
            
        }
        return 0
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 108
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LC", for: indexPath) as! laundriesCell
        if let laundryData = self.laundriesData?[indexPath.row]{
            var deliveryCost : String?
            switch laundryData.deliveryPrice {
            case .double(let delivery):
                deliveryCost = "\(delivery)"
            case .string(let delivery):
                deliveryCost = delivery
            }
            cell.updateCell(laundryImageUrl: laundryData.img, laundryName: laundryData.name, laundryRate: laundryData.totalRate, minimumPrice: laundryData.minimumPrice, deliveryPrice: deliveryCost ?? "")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if guestFlag == false{
            if let laundryData = self.laundriesData?[indexPath.row]{
                animationView?.play()
                animationView?.isHidden = false
                if #available(iOS 13.0, *) {
                    let laundryDetailsVC : laundryDetailsVC = self.storyboard?.instantiateViewController(identifier: "LDVC") as! laundryDetailsVC
                    let parameter = ["laundary_id":"\(laundryData.id)"]
                    NetworkService.shared.requestLaundryDetails(param: parameter) { (response) in
                        laundryDetailsVC.laundryDetails = response.data
                        laundryDetailsVC.userCartID = self.user!.cartID
                        laundryDetailsVC.userAddressId = self.user!.userAddress[self.addressIndex!].id
                        self.animationView?.isHidden = true
                        self.animationView?.stop()
                        self.navigationController?.pushViewController(laundryDetailsVC, animated: true)
                    } onError: { (error) in
                        debugPrint(error)
                    }
                } else {
                    let laundryDetailsVC : laundryDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "LDVC") as! laundryDetailsVC
                    let parameter = ["laundary_id":"\(laundryData.id)"]
                    NetworkService.shared.requestLaundryDetails(param: parameter) { (response) in
                        laundryDetailsVC.laundryDetails = response.data
                        laundryDetailsVC.userCartID = self.user!.cartID
                        laundryDetailsVC.userAddressId = self.user!.userAddress[self.addressIndex!].id
                        self.animationView?.isHidden = true
                        self.animationView?.stop()
                        self.navigationController?.pushViewController(laundryDetailsVC, animated: true)
                    } onError: { (error) in
                        debugPrint(error)
                    }
                }
            //self.navigationController?.pushViewController(laundryDetailsVC, animated: true)
            }
        }else{
            setupSignupAlert(title: "fail".localized, message: "Signup Required To Proceed")
        }
    }
    
}

//
//  laundriesVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/6/21.
//

import UIKit
import Lottie

@available(iOS 13.0, *)
class laundriesVC: UIViewController {

    @IBOutlet weak var laundriesTVC: UITableView!
    @IBOutlet weak var reorderBtn: basicShadowedBtn!
    @IBOutlet weak var laundriesCount: UILabel!
    
    var user : User?
    var addressIndex : Int?
    var laundriesData : [Laundry]?
    var animationView: AnimationView?

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
        requestLaundries()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laundriesTVC.delegate = self
        laundriesTVC.dataSource = self
        reorderBtn.isCircleButton()
        setUpAnimation()
        laundriesTVC.tableFooterView = UIView()
        if let user = self.user{
            print(user.userAddress!)
        }
    }
    
    //will pass address index
    func initUserData(user:User){
        self.user = user
    }
    
    func requestLaundries(){
        view.addSubview(animationView!)
        animationView?.isHidden = false
        animationView?.play()
        guard let index = self.addressIndex else{return}
        let userAddress = user?.userAddress[index]
        let addressID = userAddress?.id
        let parameter = [
            "address_id":"\(addressID!)",
            "lat":"\(userAddress!.lat)",
            "long":"\(userAddress!.long)"
        ]
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
    
    @IBAction func reorderBtnPressed(_ sender: Any) {
        let reorderingLaundriesPopup : reorderingLaundriesPopupVC = self.storyboard?.instantiateViewController(identifier: "RLPVC") as! reorderingLaundriesPopupVC
        self.present(reorderingLaundriesPopup, animated: true)
    }
    
}

@available(iOS 13.0, *)
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
            cell.updateCell(laundryImageUrl: laundryData.img, laundryName: laundryData.name, laundryRate: laundryData.totalRate, minimumPrice: laundryData.minimumPrice, deliveryPrice: laundryData.deliveryPrice)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let laundryData = self.laundriesData?[indexPath.row]{
            animationView?.play()
            animationView?.isHidden = false
        let laundryDetailsVC : laundryDetailsVC = self.storyboard?.instantiateViewController(identifier: "LDVC") as! laundryDetailsVC
            let parameter = ["laundary_id":"\(laundryData.id)"]
            NetworkService.shared.requestLaundryDetails(param: parameter) { (response) in
                laundryDetailsVC.laundryDetails = response.data
                self.animationView?.isHidden = true
                self.animationView?.stop()
                self.navigationController?.pushViewController(laundryDetailsVC, animated: true)
                
            } onError: { (error) in
                debugPrint(error)
            }
        //self.navigationController?.pushViewController(laundryDetailsVC, animated: true)
        }
    }
    
}

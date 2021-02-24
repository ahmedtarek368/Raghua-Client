//
//  favoriteLaundryVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/19/21.
//

import UIKit
import Lottie

class favoriteLaundryVC: UIViewController {

    var favoriteLaundries : [FavoriteLaundry]?
    var user: User?
    var addressIndex: Int?
    var laundryId: Int?
    
    var animationView: AnimationView?
    
    @IBOutlet weak var favoritesTV: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        setUpAnimation()
        animationView?.isHidden = false
        animationView?.play()
        requestFavoriteLaundries()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTV.delegate = self
        favoritesTV.dataSource = self
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
    
    func initUserData(user:User){
        self.user = user
    }
    
    func setupAlert(title: String, message: String){
            let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
            self.present(successfulAlert, animated: true, completion: nil)
    }
    
    func requestFavoriteLaundries() {
        NetworkService.shared.requestFavoriteLaundries { (response) in
            self.animationView?.isHidden = true
            self.animationView?.stop()
            self.favoriteLaundries = response.data
            self.favoritesTV.reloadData()
        } onError: { (error) in
            self.animationView?.isHidden = true
            self.animationView?.stop()
            self.setupAlert(title: "fail".localized, message: error)
        }
    }
    
}

extension favoriteLaundryVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let favoriteLaundries = self.favoriteLaundries {
            return favoriteLaundries.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : favoriteLaundryCell = tableView.dequeueReusableCell(withIdentifier: "FLC", for: indexPath) as! favoriteLaundryCell
        if let favLaundry = favoriteLaundries?[indexPath.row]{
            cell.updateCell(laundryId: favLaundry.id, laundryImageUrl: favLaundry.img, laundryName: favLaundry.name, laundryRate: favLaundry.totalRate, minimumPrice: favLaundry.minimumPrice, deliveryPrice: favLaundry.deliveryPrice)
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        animationView?.isHidden = false
        animationView?.play()
        let favLaundry = self.favoriteLaundries![indexPath.row]
        let storyboard = UIStoryboard(name: "Laundries", bundle: nil)
        if #available(iOS 13.0, *) {
            let laundryDetailsVC : laundryDetailsVC = storyboard.instantiateViewController(identifier: "LDVC") as! laundryDetailsVC
            let parameter = ["laundary_id":"\(favLaundry.id)"]
            NetworkService.shared.requestLaundryDetails(param: parameter) { (response) in
                laundryDetailsVC.laundryDetails = response.data
                laundryDetailsVC.userCartID = self.user!.cartID
                laundryDetailsVC.userAddressId = self.user!.userAddress[self.addressIndex!].id
                laundryDetailsVC.laundryID = favLaundry.id
                self.animationView?.isHidden = true
                self.animationView?.stop()
                self.navigationController?.pushViewController(laundryDetailsVC, animated: true)
            } onError: { (error) in
                self.animationView?.isHidden = true
                self.animationView?.stop()
            }
        } else {
            let laundryDetailsVC : laundryDetailsVC = storyboard.instantiateViewController(withIdentifier: "LDVC") as! laundryDetailsVC
            let parameter = ["laundary_id":"\(favLaundry.id)"]
            NetworkService.shared.requestLaundryDetails(param: parameter) { (response) in
                laundryDetailsVC.laundryDetails = response.data
                laundryDetailsVC.userCartID = self.user!.cartID
                laundryDetailsVC.userAddressId = self.user!.userAddress[self.addressIndex!].id
                laundryDetailsVC.laundryID = favLaundry.id
                self.animationView?.isHidden = true
                self.animationView?.stop()
                self.navigationController?.pushViewController(laundryDetailsVC, animated: true)
            } onError: { (error) in
                self.animationView?.isHidden = true
                self.animationView?.stop()
            }
        }
    }
}

extension favoriteLaundryVC: updateFavorites{
    
    func updateFavorites() {
        requestFavoriteLaundries()
    }
}

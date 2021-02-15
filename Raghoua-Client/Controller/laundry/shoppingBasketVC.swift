//
//  shoppingBasketVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/12/21.
//

import UIKit

@available(iOS 13.0, *)
class shoppingBasketVC: UIViewController{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var basketTV: UITableView!
    
    let sectionsTitles : [String] = ["your order".localized,"delivering items date".localized,"receiving items date".localized,"purchase voucher".localized,"payment summary".localized]
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basketTV.delegate = self
        basketTV.dataSource = self
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        let purchaseWarningPopupView : purchaseWarningBottomPopupVC = self.storyboard?.instantiateViewController(identifier: "PWBPVC") as! purchaseWarningBottomPopupVC
        purchaseWarningPopupView.delegate = self
        self.present(purchaseWarningPopupView, animated: true)
    }
    
}

@available(iOS 13.0, *)
extension shoppingBasketVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsTitles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "TH")
        let headerTitle : UILabel = header?.viewWithTag(2) as! UILabel
        headerTitle.text = sectionsTitles[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 603
        }else if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3{
            return 60
        }
        return 178
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let myOrdersCell : myOrdersCell = tableView.dequeueReusableCell(withIdentifier: "OC", for: indexPath) as! myOrdersCell
            let titles = ["سجاد","ثوب (صيفية)"]
            myOrdersCell.setSectionHeaderTitle(title: titles)
            return myOrdersCell
        case 1:
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DC", for: indexPath)
            return cell
        case 2:
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "DC", for: indexPath)
            return cell
        case 3:
            let purchaseVoucherCell : purchaseVoucherCell = tableView.dequeueReusableCell(withIdentifier: "PVC", for: indexPath) as! purchaseVoucherCell
            purchaseVoucherCell.setupCellView()
            return purchaseVoucherCell 
        default:
            let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "PBC", for: indexPath)
            return cell
        }
    }
    
}

@available(iOS 13.0, *)
extension shoppingBasketVC: dismissPopup{
    func didDismissPopup() {
        let paymentMethodsView : paymentMethodVC = self.storyboard?.instantiateViewController(identifier: "PMVC") as! paymentMethodVC
        self.navigationController?.pushViewController(paymentMethodsView, animated: true)
    }
    
    
}

//
//  orderDetailsVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit

class orderDetailsVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var orderBriefTV: UITableView!
    
    var cellNibName: String?
    var reuseId: String?
    let sectionTitles : [String] = ["","order details".localized,"your order".localized]
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderBriefTV.delegate = self
        orderBriefTV.dataSource = self
        orderBriefTV.contentInsetAdjustmentBehavior =  .never
        orderBriefTV.register(UINib(nibName: "waitingRateOrderCell", bundle: nil), forCellReuseIdentifier: "WRC")
        orderBriefTV.register(UINib(nibName: "deniedOrderDetailsCell", bundle: nil), forCellReuseIdentifier: "DODC")
        orderBriefTV.register(UINib(nibName: "waitingCashPaymentDetailsCell", bundle: nil), forCellReuseIdentifier: "WCPDC")
        orderBriefTV.register(UINib(nibName: "creditPaymentDetailsCell", bundle: nil), forCellReuseIdentifier: "CPDC")
        orderBriefTV.register(UINib(nibName: "orderDetailsCell", bundle: nil), forCellReuseIdentifier: "RODC")
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension orderDetailsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }else {
            return 73
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section <= 1 {
            return UITableView.automaticDimension
        }else{
            return 770
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let header = tableView.dequeueReusableCell(withIdentifier: "MH")
            let headerTitle : UILabel = header?.viewWithTag(3) as! UILabel
            headerTitle.text = sectionTitles[section]
            return header
        }else if section == 1{
            let header = tableView.dequeueReusableCell(withIdentifier: "MH")
            let headerTitle : UILabel = header?.viewWithTag(3) as! UILabel
            headerTitle.text = sectionTitles[section]
            return header
        }else{
            let header = tableView.dequeueReusableCell(withIdentifier: "MH")
            let headerTitle : UILabel = header?.viewWithTag(3) as! UILabel
            headerTitle.text = sectionTitles[section]
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            if reuseId == "ODC"{
                let cell: deniedOrderDetailsCell = tableView.dequeueReusableCell(withIdentifier: "DODC", for: indexPath) as! deniedOrderDetailsCell
                return cell
            }else if reuseId == "WCPC"{
                let cell: waitingCashPaymentDetailsCell = tableView.dequeueReusableCell(withIdentifier: "WCPDC", for: indexPath) as! waitingCashPaymentDetailsCell
                return cell
            }else if reuseId == "OCC"{
                let cell: waitingRateOrderCell = tableView.dequeueReusableCell(withIdentifier: "WRC", for: indexPath) as! waitingRateOrderCell
                cell.delegate = self
                return cell
            }else{
                let cell: creditPaymentDetailsCell = tableView.dequeueReusableCell(withIdentifier: "CPDC", for: indexPath) as! creditPaymentDetailsCell
                return cell
            }
        }else if indexPath.section == 1{
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "RODC", for: indexPath)
            return cell
        }else{
            let cell : myRecieptOrdersCell = tableView.dequeueReusableCell(withIdentifier: "MROC") as! myRecieptOrdersCell
            return cell
        }
    }
    
}

extension orderDetailsVC: reloadData{
    func reloadData() {
        orderBriefTV.reloadData()
    }
}

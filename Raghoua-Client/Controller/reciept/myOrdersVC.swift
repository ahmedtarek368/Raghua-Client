//
//  myOrdersVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/17/21.
//

import UIKit

class myOrdersVC: UIViewController {


    @IBOutlet weak var myOrdersTV: UITableView!
    
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
        myOrdersTV.delegate = self
        myOrdersTV.dataSource = self
        myOrdersTV.register(UINib(nibName: "waitingCashPaymentCell", bundle: nil), forCellReuseIdentifier: "WCPC")
        myOrdersTV.register(UINib(nibName: "orderDenieCell", bundle: nil), forCellReuseIdentifier: "ODC")
        myOrdersTV.register(UINib(nibName: "orderCompleteCell", bundle: nil), forCellReuseIdentifier: "OCC")
        myOrdersTV.register(UINib(nibName: "creditPayCell", bundle: nil), forCellReuseIdentifier: "CPC")
    }

}

extension myOrdersVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell : waitingCashPaymentCell = tableView.dequeueReusableCell(withIdentifier: "WCPC", for: indexPath) as! waitingCashPaymentCell
            return cell
        }else if indexPath.row == 1{
            let cell : creditPayCell = tableView.dequeueReusableCell(withIdentifier: "CPC", for: indexPath) as! creditPayCell
            return cell
        }else if indexPath.row == 2{
            let cell : orderCompleteCell = tableView.dequeueReusableCell(withIdentifier: "OCC", for: indexPath) as! orderCompleteCell
            return cell
        }else if indexPath.row == 3{
            let cell : orderDenieCell = tableView.dequeueReusableCell(withIdentifier: "ODC", for: indexPath) as! orderDenieCell
            return cell
        }else{
            let cell : orderDenieCell = tableView.dequeueReusableCell(withIdentifier: "ODC", for: indexPath) as! orderDenieCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if #available(iOS 13.0, *) {
            let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(identifier: "ODVC") as! orderDetailsVC
            orderDetailsView.cellNibName = "orderDenieCell"
            orderDetailsView.reuseId =  "ODC"
            self.navigationController?.pushViewController(orderDetailsView, animated: true)
        } else {
            let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ODVC") as! orderDetailsVC
            self.navigationController?.pushViewController(orderDetailsView, animated: true)
        }
        
    }
}

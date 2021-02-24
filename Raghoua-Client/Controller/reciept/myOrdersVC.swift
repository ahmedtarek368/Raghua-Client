//
//  myOrdersVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/17/21.
//

import UIKit

class myOrdersVC: UIViewController {

    @IBOutlet weak var myOrdersTV: UITableView!
    
    var myOrders: [OrderData]?
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        requestMyOrders()
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
    
    func requestMyOrders(){
        NetworkService.shared.requestMyOrders { (response) in
            self.myOrders = response.data
            self.myOrdersTV.reloadData()
            print(response)
        } onError: { (error) in
            self.setupAlert(title: "fail".localized, message: error)
        }

    }
    
    func setupAlert(title: String, message: String){
        let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
        self.present(successfulAlert, animated: true, completion: nil)
    }
    
    func setupView(){
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
    
    func requestMyOrderDetails(orderId: String,success: @escaping (OrderDetails) -> Void, fail: @escaping (String) -> Void){
        let parameter = ["order_id":orderId]
        NetworkService.shared.requestOrderDetails(parameter: parameter) { (response) in
            success(response.data)
        } onError: { (error) in
            fail(error)
        }

    }
    
    func calculateItemsServicesCellHeight(order: OrderDetails) -> Int {
        let itemsCount : Int = order.items.count
        var cellHeight : Int = 0
        let itemHeight : Int = 57
        let serviceHeight : Int = 82
        for i in 0..<itemsCount{
            cellHeight = cellHeight + itemHeight
            let servicesCount : Int = order.items[i].services.count
            for _ in 0..<servicesCount {
                cellHeight = cellHeight + serviceHeight
            }
        }
        return cellHeight
    }

}

extension myOrdersVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let myOrders = self.myOrders{
            return myOrders.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = self.myOrders![indexPath.row]
        let orderStatus = order.status
        
        if orderStatus == 0 || orderStatus == -2 || orderStatus == -3 {
            let cell : waitingCashPaymentCell = tableView.dequeueReusableCell(withIdentifier: "WCPC", for: indexPath)
                as! waitingCashPaymentCell
            cell.updateCell(laundryName: order.laundryName, creationDate: "\(order.createdAt)", orderNumber: order.orderNumber, servicesQuantity: "\(order.serviceNumber)", totalCost: order.total, statusMessage: "order under revision".localized, orderStatus: "order under revision".localized, order: order)
            cell.deliveryInfoHidden()
            cell.delegate = self
            return cell
        }else if orderStatus == 1{
            let cell : creditPayCell = tableView.dequeueReusableCell(withIdentifier: "CPC", for: indexPath) as! creditPayCell
            cell.updateCell(laundryName: order.laundryName, creationDate: "\(order.createdAt)", orderNumber: order.orderNumber, servicesQuantity: "\(order.serviceNumber)", totalCost: order.total)
            cell.delegate = self
            return cell
        }else if orderStatus == 2{
            let cell : orderCompleteCell = tableView.dequeueReusableCell(withIdentifier: "OCC", for: indexPath) as! orderCompleteCell
            cell.updateCell(laundryName: order.laundryName, creationDate: "\(order.createdAt)", orderNumber: order.orderNumber, servicesQuantity: "\(order.serviceNumber)", totalCost: order.total)
            cell.delegate = self
            return cell
        }else if orderStatus == -1{
            let cell : orderDenieCell = tableView.dequeueReusableCell(withIdentifier: "ODC", for: indexPath) as! orderDenieCell
            cell.updateCell(laundryName: order.laundryName, creationDate: "\(order.createdAt)", orderNumber: order.orderNumber, servicesQuantity: "\(order.serviceNumber)", totalCost: order.total)
            cell.delegate = self
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.reuseIdentifier == "ODC"{
            print("Denied cell")
            //
        }else if cell?.reuseIdentifier == "OCC"{
            //
        }else if cell?.reuseIdentifier == "WCPC"{
            print("waiting cash cell")
            //
        }else {
            print("credit cell")
            //
        }
    }
}


extension myOrdersVC: pushToDeniedOrderDetails{
    func pushToDeniedOrderDetails() {
        if #available(iOS 13.0, *) {
            let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(identifier: "ODVC") as! orderDetailsVC
            orderDetailsView.cellNibName = "orderDenieCell"
            orderDetailsView.reuseId =  "ODC"
            self.navigationController?.pushViewController(orderDetailsView, animated: true)
        } else {
            let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ODVC") as! orderDetailsVC
            orderDetailsView.cellNibName = "orderDenieCell"
            orderDetailsView.reuseId =  "ODC"
            self.navigationController?.pushViewController(orderDetailsView, animated: true)
        }
    }
}

extension myOrdersVC: pushToCreditPaymentDetails{
    func pushToCreditPaymentDetails() {
        if #available(iOS 13.0, *) {
            let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(identifier: "ODVC") as! orderDetailsVC
            orderDetailsView.cellNibName = "creditPayCell"
            orderDetailsView.reuseId =  "CPC"
            self.navigationController?.pushViewController(orderDetailsView, animated: true)
        } else {
            let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ODVC") as! orderDetailsVC
            orderDetailsView.cellNibName = "creditPayCell"
            orderDetailsView.reuseId =  "CPC"
            self.navigationController?.pushViewController(orderDetailsView, animated: true)
        }
    }
}

extension myOrdersVC: pushToCompleteOrderDetails{
    func pushToCompleteOrderDetails() {
        if #available(iOS 13.0, *) {
            let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(identifier: "ODVC") as! orderDetailsVC
            orderDetailsView.cellNibName = "orderCompleteCell"
            orderDetailsView.reuseId =  "OCC"
            self.navigationController?.pushViewController(orderDetailsView, animated: true)
        } else {
            let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ODVC") as! orderDetailsVC
            orderDetailsView.cellNibName = "orderCompleteCell"
            orderDetailsView.reuseId =  "OCC"
            self.navigationController?.pushViewController(orderDetailsView, animated: true)
        }
    }
}

extension myOrdersVC: pushToWaitingCashPaymentOrderDetails{
    func pushToWaitingCashPaymentOrderDetails(order: OrderData) {
        requestMyOrderDetails(orderId: "\(order.id)") { (orderDetails) in
            let cellHeight = self.calculateItemsServicesCellHeight(order: orderDetails)
            if #available(iOS 13.0, *) {
                let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(identifier: "ODVC") as! orderDetailsVC
                orderDetailsView.order = orderDetails
                orderDetailsView.cellHeight = cellHeight
                orderDetailsView.cellNibName = "waitingCashPaymentCell"
                orderDetailsView.reuseId =  "WCPC"
                self.navigationController?.pushViewController(orderDetailsView, animated: true)
            } else {
                let orderDetailsView : orderDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ODVC") as! orderDetailsVC
                orderDetailsView.order = orderDetails
                orderDetailsView.cellHeight = cellHeight
                orderDetailsView.cellNibName = "waitingCashPaymentCell"
                orderDetailsView.reuseId =  "WCPC"
                self.navigationController?.pushViewController(orderDetailsView, animated: true)
            }
        } fail: { (error) in
            
        }
    }
}

//
//  shoppingBasketVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/12/21.
//

import UIKit

class shoppingBasketVC: UIViewController{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var basketTV: UITableView!
    
    var delegate: updateCart?
    var userCart: UserCart?
    var ordersCellHeight: Int?
    var minimumPrice: Int?
    var order = Order()
    
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
        self.view.hideKeyBoardWhenTappedAround()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        delegate!.updateCart()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        checkOrderTotalPrice()
    }
    
    func checkOrderTotalPrice(){
        let subTotal = order.subTotal
        if subTotal! < self.minimumPrice!{
            presentTotalPriceUnderMinimumPopup()
        }else{
            if #available(iOS 13.0, *) {
                let paymentMethodsView : paymentMethodVC = self.storyboard?.instantiateViewController(identifier: "PMVC") as! paymentMethodVC
                paymentMethodsView.order = self.order
                self.navigationController?.pushViewController(paymentMethodsView, animated: true)
            } else {
                let paymentMethodsView : paymentMethodVC = self.storyboard?.instantiateViewController(withIdentifier: "PMVC") as! paymentMethodVC
                paymentMethodsView.order = self.order
                self.navigationController?.pushViewController(paymentMethodsView, animated: true)
            }
        }
    }
    
    func presentTotalPriceUnderMinimumPopup(){
        if #available(iOS 13.0, *) {
            let purchaseWarningPopupView : purchaseWarningBottomPopupVC = self.storyboard?.instantiateViewController(identifier: "PWBPVC") as! purchaseWarningBottomPopupVC
            purchaseWarningPopupView.delegate = self
            self.present(purchaseWarningPopupView, animated: true)
        } else {
            let purchaseWarningPopupView : purchaseWarningBottomPopupVC = self.storyboard?.instantiateViewController(withIdentifier: "PWBPVC") as! purchaseWarningBottomPopupVC
            purchaseWarningPopupView.delegate = self
            self.present(purchaseWarningPopupView, animated: true)
        }
    }
    
    func calculateItemsServicesSubTotal(userCart: UserCart) -> Int {
        let itemsCount : Int = userCart.items.count
        var subTotal: Int = 0
        for i in 0..<itemsCount{
            let servicesCount : Int = userCart.items[i].services.count
            for j in 0..<servicesCount {
                let servicePrice = userCart.items[i].services[j].price
                var serviceQuantity = userCart.items[i].services[j].quantity
                if serviceQuantity == nil {
                    serviceQuantity = 0
                }
                if let itemSize = userCart.items[i].services[j].width{
                    subTotal = subTotal + (servicePrice * serviceQuantity! * itemSize)
                }else{
                    subTotal = subTotal + (servicePrice * serviceQuantity!)
                }
            }
        }
        return subTotal
    }
    
    func calculateItemsServicesNumber(userCart: UserCart) -> Int {
        let itemsCount : Int = userCart.items.count
        var cellHeight : Int = 0
        let itemHeight : Int = 51
        let serviceHeight : Int = 82
        for i in 0..<itemsCount{
            cellHeight = cellHeight + itemHeight
            let servicesCount : Int = userCart.items[i].services.count
            for _ in 0..<servicesCount {
                cellHeight = cellHeight + serviceHeight
            }
        }
        return cellHeight
    }
    
}

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
            if let cellHeight = self.ordersCellHeight{
                return CGFloat(cellHeight)
            }
            return 603
        }else if indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3{
            return 60
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let myOrdersCell : myOrdersCell = tableView.dequeueReusableCell(withIdentifier: "OC", for: indexPath) as! myOrdersCell
            print(self.userCart!)
            myOrdersCell.delegate = self
            myOrdersCell.updateCell(userCart: self.userCart!)
            return myOrdersCell
        case 1:
            let cell : datePickingCell = tableView.dequeueReusableCell(withIdentifier: "DC", for: indexPath) as! datePickingCell
            cell.delegate = self
            cell.cellIndex = indexPath.section
            return cell
        case 2:
            let cell : datePickingCell = tableView.dequeueReusableCell(withIdentifier: "DC", for: indexPath) as! datePickingCell
            cell.cellIndex = indexPath.section
            cell.delegate = self
            return cell
        case 3:
            let purchaseVoucherCell : purchaseVoucherCell = tableView.dequeueReusableCell(withIdentifier: "PVC", for: indexPath) as! purchaseVoucherCell
            purchaseVoucherCell.delegate = self
            purchaseVoucherCell.updateCell(subTotal: self.order.subTotal!)
            return purchaseVoucherCell 
        default:
            let cell : costDetailsCell = tableView.dequeueReusableCell(withIdentifier: "PBC", for: indexPath) as! costDetailsCell
            if self.order.voucherDiscount == nil || self.order.voucherDiscount == 0{
                if let subTotal = order.subTotal, let deliveryFees = order.deliveryFees{
                    cell.paymentWithoutVoucher(subTotal: subTotal, deliveryFees: deliveryFees)
                    //self.order.setTotal(total: subTotal+deliveryFees)
                }
            }else{
                if let subTotal = order.subTotal, let deliveryFees = order.deliveryFees, let voucher = order.voucherDiscount{
                    cell.paymentWithVoucher(subTotal: subTotal, deliveryFees: deliveryFees, VoucherDiscount: voucher)
                    //self.order.setTotal(total: subTotal+deliveryFees-voucher)
                }
            }
            return cell
        }
    }
    
}

extension shoppingBasketVC: dismissPopup{
    func didDismissPopup() {
        order.setMinimum(minimum: "1")
        if #available(iOS 13.0, *) {
            let paymentMethodsView : paymentMethodVC = self.storyboard?.instantiateViewController(identifier: "PMVC") as! paymentMethodVC
            paymentMethodsView.order = self.order
            self.navigationController?.pushViewController(paymentMethodsView, animated: true)
        } else {
            let paymentMethodsView : paymentMethodVC = self.storyboard?.instantiateViewController(withIdentifier: "PMVC") as! paymentMethodVC
            paymentMethodsView.order = self.order
            self.navigationController?.pushViewController(paymentMethodsView, animated: true)
        }
    }
}

extension shoppingBasketVC: updateCartView{
    func updateCellHeight(userCart: UserCart) {
        self.userCart = userCart
        let cellHeight = self.calculateItemsServicesNumber(userCart: userCart)
        self.ordersCellHeight = cellHeight
        let subTotal = calculateItemsServicesSubTotal(userCart: userCart)
        self.order.setSubTotal(subTotal: subTotal)
        self.basketTV.reloadData()
    }
    
    func updateCart(userCart: UserCart){
        self.userCart = userCart
        let subTotal = calculateItemsServicesSubTotal(userCart: userCart)
        self.order.setSubTotal(subTotal: subTotal)
        self.basketTV.reloadData()
    }
}

extension shoppingBasketVC: confirmedVoucher{
    
    func confirmedVoucher(discountAmount: Int) {
        self.order.setVoucherDiscount(voucherDiscount: discountAmount)
        basketTV.reloadData()
    }
    
    func deniedVoucher(){
        self.order.setVoucherDiscount(voucherDiscount: 0)
        basketTV.reloadData()
    }
}

extension shoppingBasketVC: confirmDeliverRecieveDateTime{
    func confirmDeliverDate(date: String) {
        self.order.setDeliveryDate(deliveryDate: date)
    }
    
    func confirmDeliverTime(time: String) {
        self.order.setDeliveryTime(deliveryTime: time)
    }
    
    func confirmRecieveDate(date: String) {
        self.order.setReceiveDate(receiveDate: date)
    }
    
    func confirmRecieveTime(time: String) {
        self.order.setReceiveTime(receiveTime: time)
    }
}


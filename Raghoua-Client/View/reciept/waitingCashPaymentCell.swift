//
//  waitingCashPaymentCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit

class waitingCashPaymentCell: UITableViewCell {

    @IBOutlet weak var laundryName: basicLabel!
    @IBOutlet weak var creationDate: basicLabel!
    @IBOutlet weak var orderNumber: basicLabel!
    @IBOutlet weak var servicesQuantity: basicLabel!
    @IBOutlet weak var totalCost: basicLabel!
    @IBOutlet weak var deliveryInfo: UIStackView!
    @IBOutlet weak var orderStatus: basicLabel!
    
    var delegate: pushToWaitingCashPaymentOrderDetails?
    
    @IBOutlet weak var rightConstraint: UIView!
    @IBOutlet weak var mainRoundedView: UIView!
    @IBOutlet weak var labelOrangeView: UIView!
    @IBOutlet weak var statusMessage: UILabel!
    
    var order: OrderData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func deliveryInfoHidden(){
        self.deliveryInfo.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainRoundedView.layer.cornerRadius = 12
        self.labelOrangeView.layer.cornerRadius = 8
        //customizePayWithCreditCardCell()
    }
    
    func updateCell(laundryName: String, creationDate: String, orderNumber: String, servicesQuantity: String, totalCost: String, statusMessage: String, orderStatus: String, order: OrderData){
        self.order = order
        self.laundryName.text = laundryName
        self.creationDate.text = creationDate
        self.orderNumber.text = orderNumber
        self.servicesQuantity.text = servicesQuantity
        self.totalCost.text = totalCost
        self.statusMessage.text = statusMessage
        self.orderStatus.text = orderStatus
    }
    
    @IBAction func showOrderDetailsBtnPressed(_ sender: Any) {
        if let order = self.order{
            delegate!.pushToWaitingCashPaymentOrderDetails(order: order)
        }
    }
    
}

//
//  waitingCashPaymentDetailsCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/21/21.
//

import UIKit

class waitingCashPaymentDetailsCell: UITableViewCell {

    @IBOutlet weak var mainRoundedView: UIView!
    @IBOutlet weak var labelOrangeView: UIView!
    @IBOutlet weak var statusMessage: UILabel!
    @IBOutlet weak var orderDate: basicLabel!
    @IBOutlet weak var orderNumber: basicLabel!
    @IBOutlet weak var servicesQuantity: basicLabel!
    @IBOutlet weak var totalCost: basicLabel!
    @IBOutlet weak var laundryName: basicLabel!
    @IBOutlet weak var orderStatus: basicLabel!
    @IBOutlet weak var deliveryInfo: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainRoundedView.layer.cornerRadius = 12
        self.labelOrangeView.layer.cornerRadius = 8
        //customizePayWithCreditCardCell()
    }
    
    func deliveryInfoHidden(){
        self.deliveryInfo.isHidden = true
    }

    func updateCell(laundryName: String, creationDate: String, orderNumber: String, servicesQuantity: String, totalCost: String, statusMessage: String, orderStatus: String){
        self.laundryName.text = laundryName
        self.orderDate.text = creationDate
        self.orderNumber.text = orderNumber
        self.servicesQuantity.text = servicesQuantity + "   \("services".localized)"
        self.totalCost.text = totalCost
        self.statusMessage.text = statusMessage
        self.orderStatus.text = orderStatus
    }
    
}

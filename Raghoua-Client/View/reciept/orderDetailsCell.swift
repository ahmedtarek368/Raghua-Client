//
//  orderDetailsCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/19/21.
//

import UIKit

class orderDetailsCell: UITableViewCell {

    
    @IBOutlet weak var deliveryFees: basicLabel!
    @IBOutlet weak var totalPrice: basicLabel!
    @IBOutlet weak var paymentMethod: basicLabel!
    @IBOutlet weak var itemsPickingDate: basicLabel!
    @IBOutlet weak var itemsDeliveringDate: basicLabel!
    @IBOutlet weak var address: basicLabel!
    @IBOutlet weak var addressDetails: basicTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if "lang".localized == "ar"{
            deliveryFees.textAlignment = .left
            totalPrice.textAlignment = .left
            paymentMethod.textAlignment = .left
            itemsPickingDate.textAlignment = .left
            itemsDeliveringDate.textAlignment = .left
        }
    }

    func updateCell(orderDetails: OrderDetails){
        self.deliveryFees.text = "\(orderDetails.deliveryPrice) \("riyal".localized)"
        self.totalPrice.text = "\(orderDetails.total) \("riyal".localized)"
        if orderDetails.paymentMethod == 2{
            self.paymentMethod.text = "\("credit card".localized)"
        }else{
            self.paymentMethod.text = "\("cash".localized)"
        }
        itemsPickingDate.text = "\(orderDetails.receivedDate), \(orderDetails.receivedTime)"
        itemsDeliveringDate.text = "\(orderDetails.deliveryDate), \(orderDetails.deliveryTime)"
        address.text = orderDetails.address.address
        addressDetails.text = "\(orderDetails.address.nearstPlace), \(orderDetails.address.street), \(orderDetails.address.floorNumber), \(orderDetails.address.departNumber)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

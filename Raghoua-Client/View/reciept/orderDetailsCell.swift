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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

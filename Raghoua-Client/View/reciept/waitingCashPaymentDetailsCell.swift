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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainRoundedView.layer.cornerRadius = 12
        self.labelOrangeView.layer.cornerRadius = 8
        //customizePayWithCreditCardCell()
    }

    
}

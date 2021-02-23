//
//  waitingCashPaymentCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit

class waitingCashPaymentCell: UITableViewCell {

    var delegate: pushToWaitingCashPaymentOrderDetails?
    
    @IBOutlet weak var rightConstraint: UIView!
    @IBOutlet weak var mainRoundedView: UIView!
    @IBOutlet weak var labelOrangeView: UIView!
    @IBOutlet weak var statusMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.mainRoundedView.layer.cornerRadius = 12
        self.labelOrangeView.layer.cornerRadius = 8
        //customizePayWithCreditCardCell()
    }
    
    @IBAction func showOrderDetailsBtnPressed(_ sender: Any) {
        delegate!.pushToWaitingCashPaymentOrderDetails()
    }
    
}

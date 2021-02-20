//
//  waitingCashPaymentCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit

class waitingCashPaymentCell: UITableViewCell {

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
    
    func isNotRoundedCell(){
        mainRoundedView.layer.cornerRadius = 0
        mainRoundedView.translatesAutoresizingMaskIntoConstraints = false
        mainRoundedView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainRoundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        mainRoundedView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        mainRoundedView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
}

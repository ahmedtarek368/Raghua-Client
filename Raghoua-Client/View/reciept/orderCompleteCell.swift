//
//  orderCompleteCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit
import SwiftyStarRatingView

class orderCompleteCell: UITableViewCell {

    var delegate: pushToCompleteOrderDetails?
    
    @IBOutlet weak var mainRoundedOrderView: UIView!
    @IBOutlet weak var orderDate: basicLabel!
    @IBOutlet weak var orderNumber: basicLabel!
    @IBOutlet weak var totalCost: basicLabel!
    @IBOutlet weak var servicesQuantity: basicLabel!
    @IBOutlet weak var starRate: SwiftyStarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if "lang".localized == "ar" {
            starRate.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainRoundedOrderView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showOrderDetailsBtnPressed(_ sender: Any) {
        delegate!.pushToCompleteOrderDetails()
    }
    
    
}

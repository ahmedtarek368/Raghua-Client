//
//  orderDenieCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit

class orderDenieCell: UITableViewCell {

    var delegate: pushToDeniedOrderDetails?

    @IBOutlet weak var laundryName: basicLabel!
    @IBOutlet weak var mainRoundedOrderView: UIView!
    @IBOutlet weak var statusMessageView: UIView!
    @IBOutlet weak var orderDate: basicLabel!
    @IBOutlet weak var orderNumber: basicLabel!
    @IBOutlet weak var totalCost: basicLabel!
    @IBOutlet weak var servicesQuantity: basicLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        statusMessageView.layer.cornerRadius = 8
        mainRoundedOrderView.layer.cornerRadius = 12
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(laundryName: String, creationDate: String, orderNumber: String, servicesQuantity: String, totalCost: String){
        self.laundryName.text = laundryName
        self.orderDate.text = creationDate
        self.orderNumber.text = orderNumber
        self.servicesQuantity.text = servicesQuantity
        self.totalCost.text = totalCost
    }
    
    @IBAction func showOrderDetailsBtnPressed(_ sender: Any) {
        delegate!.pushToDeniedOrderDetails()
    }
    
}

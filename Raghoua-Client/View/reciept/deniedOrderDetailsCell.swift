//
//  deniedOrderDetailsCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/21/21.
//

import UIKit

class deniedOrderDetailsCell: UITableViewCell {

    @IBOutlet weak var laundryName: basicLabel!
    @IBOutlet weak var statusMessageView: UIView!
    @IBOutlet weak var orderDate: basicLabel!
    @IBOutlet weak var orderNumber: basicLabel!
    @IBOutlet weak var servicesQuantity: basicLabel!
    @IBOutlet weak var totalCost: basicLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        statusMessageView.layer.cornerRadius = 8
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
    
}

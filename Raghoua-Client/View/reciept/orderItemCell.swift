//
//  orderItemCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/24/21.
//

import UIKit

class orderItemCell: UITableViewCell {

    @IBOutlet weak var quantity: basicLabel!
    @IBOutlet weak var servicePrice: basicLabel!
    @IBOutlet weak var serviceName: basicLabel!
    @IBOutlet weak var pricePerItem: basicLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCell(service: Service){
        self.serviceName.text = service.name
        self.servicePrice.text = "\(service.price)" + " \("riyal".localized)"
        self.quantity.text = "\("quantity".localized):" + "\(service.quantity ?? 0)"
        if service.priceMethod == 2 {
            self.pricePerItem.text = "\(service.width ?? 0)" + "meter".localized
        }else{
            self.pricePerItem.text = "perPiece".localized
        }
    }
    
}

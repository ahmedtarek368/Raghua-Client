//
//  serviceOrderCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/15/21.
//

import UIKit

class serviceOrderCell: UITableViewCell {

    var delegate: orderQuantity?
    var item: Item?
    var serviceIndex: Int?
    var userCartID: Int?
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var increaseQuantityBtn: UIButton!
    @IBOutlet weak var decreaseQuantityBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func increaseQuantityBtnPressed(_ sender: UIButton) {
        let quantity : Int = Int(orderQuantity.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity+1)",
            "accept":"0"
        ]
        NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
            self.orderQuantity.text = "\(quantity+1)"
            self.delegate?.increaseQuantity(serviceIndex: self.serviceIndex!)
        } onError: { (error) in
            debugPrint(error)
        }
    }
    
    @IBAction func decreaseQuantityBtnPressed(_ sender: UIButton) {
        let quantity : Int = Int(orderQuantity.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity+1)",
            "accept":"0"
        ]
        NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
            if quantity != 0 {
                self.orderQuantity.text = "\(quantity-1)"
                self.delegate?.decreaseQuantity(serviceIndex: self.serviceIndex!)
            }
        } onError: { (error) in
            debugPrint(error)
        }
    }
    
    func updateCell(item: Item, serviceIndex: Int, userCartID: Int){
        self.item = item
        self.serviceIndex = serviceIndex
        self.serviceName.text = item.services[serviceIndex].name
        self.servicePrice.text = item.services[serviceIndex].price! + " ريال"
        self.userCartID = userCartID
    }

}

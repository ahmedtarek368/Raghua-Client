//
//  cartUserItemCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/16/21.
//

import UIKit

class cartUserItemCell: UITableViewCell {

    
    @IBOutlet weak var serviceName: basicLabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var serviceQuantity: UILabel!
    
    var delegate: removeItem?
    var userCart: UserCart?
    var itemIndex: Int?
    var serviceIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func decreaseQuantityBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func increaseQuantityBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func removeServiceBtnPressed(_ sender: Any) {
        let serviceID = self.userCart!.items[itemIndex!].services[serviceIndex!].id
        NetworkService.shared.requestRemoveItemInCart(itemID: serviceID) { (response) in
            self.delegate?.removeAndReloadTable()
        } onError: { (error) in
            debugPrint(error)
        }


    }
    
    
    func updateCell(userCart: UserCart, itemIndex: Int, serviceIndex: Int){
        self.userCart = userCart
        self.itemIndex = itemIndex
        self.serviceIndex = serviceIndex
        self.serviceName.text = userCart.items[itemIndex].services[serviceIndex].name
        self.servicePrice.text = "\(userCart.items[itemIndex].services[serviceIndex].price)"
        self.serviceQuantity.text = "\(userCart.items[itemIndex].services[serviceIndex].quantity)"
    }
    
}

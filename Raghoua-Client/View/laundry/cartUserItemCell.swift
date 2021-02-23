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
    @IBOutlet weak var pricePerQuantity: UILabel!
    
    var delegate: updateUserCart?
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

    func updateQuantity(type: Int){
        let serviceID = self.userCart!.items[itemIndex!].services[serviceIndex!].id
        let quantity = Int(self.serviceQuantity.text!)
        let parameter = [
            "service_id":"\(serviceID)",
            "type":"\(type)",
            "quntitiy":"1"
        ]
        NetworkService.shared.requestUpdateUserCartData(param: parameter) { (response) in
            if type == 1{
                self.serviceQuantity.text = "\(quantity!+1)"
            }else{
                self.serviceQuantity.text = "\(quantity!-1)"
            }
            NetworkService.shared.requestUserCartData { (response) in
                self.delegate?.updateUserCart(userCart: response.data)
            } onError: { (error) in
                debugPrint(error)
            }
        } onError: { (error) in
            debugPrint(error)
        }

    }
    
    @IBAction func decreaseQuantityBtnPressed(_ sender: Any) {
        let quantity = Int(self.serviceQuantity.text!)
        if quantity != 0{
            updateQuantity(type: 0)
        }
    }
    
    @IBAction func increaseQuantityBtnPressed(_ sender: Any) {
        updateQuantity(type: 1)
    }
    
    @IBAction func removeServiceBtnPressed(_ sender: Any) {
        let serviceID = self.userCart!.items[itemIndex!].services[serviceIndex!].id
        NetworkService.shared.requestRemoveItemInCart(itemID: serviceID) { (response) in
            NetworkService.shared.requestUserCartData { (response) in
                self.delegate?.removeAndReloadTable(userCart: response.data)
            } onError: { (error) in
                debugPrint(error)
            }
        } onError: { (error) in
            debugPrint(error)
        }
    }
    
    
    func updateCell(userCart: UserCart, itemIndex: Int, serviceIndex: Int){
        self.userCart = userCart
        self.itemIndex = itemIndex
        self.serviceIndex = serviceIndex
        if userCart.items[itemIndex].priceMethod == 2{
            if let width = userCart.items[itemIndex].services[serviceIndex].width {
                pricePerQuantity.text = "\(width) \("meter".localized)"
            }
        }
        self.serviceName.text = userCart.items[itemIndex].services[serviceIndex].name
        self.servicePrice.text = "\(userCart.items[itemIndex].services[serviceIndex].price) ريال"
        self.serviceQuantity.text = "\(userCart.items[itemIndex].services[serviceIndex].quantity!)"
    }
    
}

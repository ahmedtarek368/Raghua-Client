//
//  itemSizeCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/15/21.
//

import UIKit

class itemSizeCell: UITableViewCell {

    var quantityDelegate: orderQuantity?
    var item: Item?
    var serviceIndex: Int?
    var userCartID: Int?
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var increaseQuantityBtn: UIButton!
    @IBOutlet weak var decreaseQuantityBtn: UIButton!
    @IBOutlet weak var itemSize: UILabel!
    var viewDelegate: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupAlert(incQuantity: Bool, title: String, message: String){
        let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if incQuantity == true {
            successfulAlert.addAction(UIAlertAction(title: "Continue".localized, style: .default , handler: confirmIncreaseQuantity(alert:)))
        }else{
            successfulAlert.addAction(UIAlertAction(title: "Continue".localized, style: .default , handler: confirmIncreaseSize(alert:)))
        }
        successfulAlert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel , handler: nil))
        viewDelegate!.present(successfulAlert, animated: true, completion: nil)
    }
    
    @objc func confirmIncreaseQuantity(alert: UIAlertAction){
        let quantity : Int = Int(orderQuantity.text!)!
        let size : Int = Int(itemSize.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity+1)",
            "service[\(serviceIndex!)][width]":"\(size)",
            "accept":"1"
        ]
        NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
            self.orderQuantity.text = "\(quantity+1)"
            NetworkService.shared.requestUserCartData { (response) in
                self.quantityDelegate?.increaseQuantity(userCart: response.data)
            } onError: { (error) in
                debugPrint(error)
            }
        } onError: { (error) in
            debugPrint(error)
        }
    }
    
    @objc func confirmIncreaseSize(alert: UIAlertAction){
        let quantity : Int = Int(orderQuantity.text!)!
        let size : Int = Int(itemSize.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity)",
            "service[\(serviceIndex!)][width]":"\(size+1)",
            "accept":"1"
        ]
        NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
            self.orderQuantity.text = "\(size+1)"
            NetworkService.shared.requestUserCartData { (response) in
                self.quantityDelegate?.increaseQuantity(userCart: response.data)
            } onError: { (error) in
                debugPrint(error)
            }
        } onError: { (error) in
            debugPrint(error)
        }
    }
    
    func updateCell(item: Item, serviceIndex: Int, userCartID: Int){
        self.item = item
        self.serviceIndex = serviceIndex
        self.serviceName.text = item.services[serviceIndex].name
        self.servicePrice.text = item.services[serviceIndex].price
        self.userCartID = userCartID
        self.itemSize.text = "0"
        self.orderQuantity.text = "0"
    }

    @IBAction func increaseQuantityBtnPressed(_ sender: UIButton) {
        let quantity : Int = Int(orderQuantity.text!)!
        let size : Int = Int(itemSize.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity+1)",
            "service[\(serviceIndex!)][width]":"\(size)",
            "accept":"0"
        ]
        NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
            self.orderQuantity.text = "\(quantity+1)"
            NetworkService.shared.requestUserCartData { (response) in
                self.quantityDelegate?.increaseQuantity(userCart: response.data)
            } onError: { (error) in
                debugPrint(error)
            }
        } onError: { (error) in
            if error == "C300"{
                self.setupAlert(incQuantity: true, title: "different laundry !".localized, message: "remove what's in the cart and add this one ?".localized)
            }else{
                debugPrint(error)
            }
        }
    }
    
    @IBAction func decreaseQuantityBtnPressed(_ sender: UIButton) {
        let quantity : Int = Int(orderQuantity.text!)!
        let size : Int = Int(itemSize.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity-1)",
            "service[\(serviceIndex!)][width]":"\(size)",
            "accept":"0"
        ]
        if quantity != 0 {
            NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
                self.orderQuantity.text = "\(quantity-1)"
                NetworkService.shared.requestUserCartData { (response) in
                    self.quantityDelegate?.decreaseQuantity(userCart: response.data)
                } onError: { (error) in
                    debugPrint(error)
                }
            } onError: { (error) in
                debugPrint(error)
            }
        }
    }
    
    @IBAction func increaseSizeBtnPressed(_ sender: Any) {
        let quantity : Int = Int(orderQuantity.text!)!
        let size : Int = Int(itemSize.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity)",
            "service[\(serviceIndex!)][width]":"\(size+1)",
            "accept":"0"
        ]
        NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
            self.itemSize.text = "\(size+1)"
            NetworkService.shared.requestUserCartData { (response) in
                self.quantityDelegate?.increaseQuantity(userCart: response.data)
            } onError: { (error) in
                debugPrint(error)
            }
        } onError: { (error) in
            if error == "C300"{
                self.setupAlert(incQuantity: false, title: "different laundry !".localized, message: "remove what's in the cart and add this one ?".localized)
            }else{
                debugPrint(error)
            }
        }
    }
    
    @IBAction func decreaseSizeBtnPressed(_ sender: Any) {
        let quantity : Int = Int(orderQuantity.text!)!
        let size : Int = Int(itemSize.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity)",
            "service[\(serviceIndex!)][width]":"\(size-1)",
            "accept":"0"
        ]
        if size != 0 {
            NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
                self.orderQuantity.text = "\(size-1)"
                NetworkService.shared.requestUserCartData { (response) in
                    self.quantityDelegate?.decreaseQuantity(userCart: response.data)
                } onError: { (error) in
                    debugPrint(error)
                }
            } onError: { (error) in
                debugPrint(error)
            }
        }
    }
}

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
    var viewDelegate: UIViewController?
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var increaseQuantityBtn: UIButton!
    @IBOutlet weak var decreaseQuantityBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupAlert(title: String, message: String){
        let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        successfulAlert.addAction(UIAlertAction(title: "Continue".localized, style: .default , handler: confirmAddServiceToCart(alert:)))
        successfulAlert.addAction(UIAlertAction(title: "Cancel".localized, style: .cancel , handler: nil))
        viewDelegate!.present(successfulAlert, animated: true, completion: nil)
    }
    
    @objc func confirmAddServiceToCart(alert: UIAlertAction){
        let quantity : Int = Int(orderQuantity.text!)!
        let service = [
            "cart_id":"\(self.userCartID!)",
            "item_id":"\(self.item!.id)",
            "service[\(serviceIndex!)][id]":"\(self.item!.services[serviceIndex!].id)",
            "service[\(serviceIndex!)][quntity]":"\(quantity+1)",
            "accept":"1"
        ]
        NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
            self.orderQuantity.text = "\(quantity+1)"
            NetworkService.shared.requestUserCartData { (response) in
                self.delegate?.increaseQuantity(userCart: response.data)
            } onError: { (error) in
                debugPrint(error)
            }
        } onError: { (error) in
            debugPrint(error)
        }
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
            NetworkService.shared.requestUserCartData { (response) in
                self.delegate?.increaseQuantity(userCart: response.data)
            } onError: { (error) in
                debugPrint(error)
            }
        } onError: { (error) in
            if error == "C300"{
                self.setupAlert(title: "different laundry !".localized, message: "remove what's in the cart and add this one ?".localized)
            }else{
                debugPrint(error)
            }
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
        if quantity != 0 {
            NetworkService.shared.requestAddServiceToCart(param: service) { (response) in
                self.orderQuantity.text = "\(quantity-1)"
                //self.delegate?.decreaseQuantity(serviceIndex: self.serviceIndex!)
                NetworkService.shared.requestUserCartData { (response) in
                    self.delegate?.decreaseQuantity(userCart: response.data)
                } onError: { (error) in
                    debugPrint(error)
                }
            } onError: { (error) in
                debugPrint(error)
            }
        }
    }
    
    func updateCell(item: Item, serviceIndex: Int, userCartID: Int){
        self.item = item
        self.serviceIndex = serviceIndex
        self.serviceName.text = item.services[serviceIndex].name
        self.servicePrice.text = item.services[serviceIndex].price! + " ريال"
        self.userCartID = userCartID
        self.orderQuantity.text = "0"
    }

}

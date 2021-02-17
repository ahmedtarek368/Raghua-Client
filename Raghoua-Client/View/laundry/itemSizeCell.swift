//
//  itemSizeCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/15/21.
//

import UIKit

class itemSizeCell: UITableViewCell {

    var sizeDelegate: orderSize?
    var delegate: orderQuantity?
    var item: Item?
    var serviceIndex: Int?
    var userCartID: Int?
    
    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    @IBOutlet weak var orderQuantity: UILabel!
    @IBOutlet weak var increaseQuantityBtn: UIButton!
    @IBOutlet weak var decreaseQuantityBtn: UIButton!
    
    @IBOutlet weak var itemSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func updateCell(serviceName: String, servicePrice: String){
//        self.serviceName.text = serviceName
//        self.servicePrice.text = servicePrice
//    }
    func updateCell(item: Item, serviceIndex: Int, userCartID: Int){
        self.item = item
        self.serviceIndex = serviceIndex
        self.serviceName.text = item.services[serviceIndex].name
        self.servicePrice.text = item.services[serviceIndex].price
        self.userCartID = userCartID
    }

    @IBAction func increaseQuantityBtnPressed(_ sender: UIButton) {
        let quantity : Int = Int(orderQuantity.text!)!
        orderQuantity.text = "\(quantity+1)"
        delegate?.increaseQuantity(serviceIndex: serviceIndex!)
    }
    
    @IBAction func decreaseQuantityBtnPressed(_ sender: UIButton) {
        let quantity : Int = Int(orderQuantity.text!)!
        if quantity != 0 {
            orderQuantity.text = "\(quantity-1)"
            delegate?.decreaseQuantity(serviceIndex: serviceIndex!)
        }
    }
    
    @IBAction func increaseSizeBtnPressed(_ sender: Any) {
        let size : Int = Int(itemSize.text!)!
        itemSize.text = "\(size+1)"
        sizeDelegate?.increaseSize()
    }
    
    @IBAction func decreaseSizeBtnPressed(_ sender: Any) {
        let size : Int = Int(itemSize.text!)!
        if size != 0 {
            itemSize.text = "\(size-1)"
            sizeDelegate?.decreaseSize()
        }
    }
}

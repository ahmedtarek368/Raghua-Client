//
//  costDetailsCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/22/21.
//

import UIKit

class costDetailsCell: UITableViewCell {

    @IBOutlet weak var subTotal: basicLabel!
    @IBOutlet weak var deliveryFees: basicLabel!
    @IBOutlet weak var purchaseVoucher: basicLabel!
    @IBOutlet weak var discount: basicLabel!
    @IBOutlet weak var totalCost: basicLabel!
    @IBOutlet weak var voucherStack: UIStackView!
    @IBOutlet weak var discountStack: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func paymentWithVoucher(subTotal: Int, deliveryFees: Int, VoucherDiscount: Int){
        voucherStack.isHidden = false
        discountStack.isHidden = false
        if subTotal == 0{
            self.subTotal.text = "\(0) ريال"
            self.deliveryFees.text = "\(0) ريال"
            self.purchaseVoucher.text = "\(0) ريال"
            voucherStack.isHidden = true
            discountStack.isHidden = true
            self.totalCost.text = "\(0) ريال"
        }else{
            self.subTotal.text = "\(subTotal) ريال"
            self.deliveryFees.text = "\(deliveryFees) ريال"
            self.purchaseVoucher.text = "\(VoucherDiscount) ريال"
            self.totalCost.text = "\(subTotal+deliveryFees-VoucherDiscount) ريال"
        }
    }
    
    func paymentWithoutVoucher(subTotal: Int, deliveryFees: Int){
        voucherStack.isHidden = true
        discountStack.isHidden = true
        if subTotal == 0{
            self.subTotal.text = "\(0) ريال"
            self.deliveryFees.text = "\(0) ريال"
            self.totalCost.text = "\(0) ريال"
        }else{
            self.subTotal.text = "\(subTotal) ريال"
            self.deliveryFees.text = "\(deliveryFees) ريال"
            self.totalCost.text = "\(subTotal+deliveryFees) ريال"
        }
    }
}

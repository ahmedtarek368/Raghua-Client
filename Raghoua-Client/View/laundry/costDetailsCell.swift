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
            self.subTotal.text = "\(0) \("riyal".localized)"
            self.deliveryFees.text = "\(0) \("riyal".localized)"
            self.purchaseVoucher.text = "\(0) \("riyal".localized)"
            voucherStack.isHidden = true
            discountStack.isHidden = true
            self.totalCost.text = "\(0) \("riyal".localized)"
        }else{
            self.subTotal.text = "\(subTotal) \("riyal".localized)"
            self.deliveryFees.text = "\(deliveryFees) \("riyal".localized)"
            self.purchaseVoucher.text = "\(VoucherDiscount) \("riyal".localized)"
            self.totalCost.text = "\(subTotal+deliveryFees-VoucherDiscount) \("riyal".localized)"
        }
    }
    
    func paymentWithoutVoucher(subTotal: Int, deliveryFees: Int){
        voucherStack.isHidden = true
        discountStack.isHidden = true
        if subTotal == 0{
            self.subTotal.text = "\(0) \("riyal".localized)"
            self.deliveryFees.text = "\(0) \("riyal".localized)"
            self.totalCost.text = "\(0) \("riyal".localized)"
        }else{
            self.subTotal.text = "\(subTotal) \("riyal".localized)"
            self.deliveryFees.text = "\(deliveryFees) \("riyal".localized)"
            self.totalCost.text = "\(subTotal+deliveryFees) \("riyal".localized)"
        }
    }
}

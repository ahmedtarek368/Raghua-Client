//
//  paymentMethodsCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/15/21.
//

import UIKit

class paymentMethodsCell: UITableViewCell {

    @IBOutlet weak var methodImage: UIImageView!
    @IBOutlet weak var methodName: basicLabel!
    @IBOutlet weak var selectedMethodMark: UIImageView!
    @IBOutlet weak var paymentOnDeliver: basicLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedMethodMark.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            selectedMethodMark.isHidden = false
        }else{
            selectedMethodMark.isHidden = true
        }
    }
    
    func updateCell(methodName: String, methodImage: String){
        self.methodName.text = methodName
        self.methodImage.image = UIImage(named: methodImage)
    }
    
    func setPaymentOnDeliverlabel(){
        self.paymentOnDeliver.isHidden = false
    }

}

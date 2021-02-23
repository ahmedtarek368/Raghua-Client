//
//  purchaseVoucherCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/13/21.
//

import UIKit

class purchaseVoucherCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var voucherTextField: basicTextField!
    @IBOutlet weak var validVoucherMark: UIImageView!
    
    var delegate: confirmedVoucher?
    var subTotal: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        voucherTextField.isTransparentTextField()
        voucherTextField.delegate = self
        self.hideKeyBoardWhenTappedAround()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(subTotal: Int){
        voucherTextField.isTransparentTextField()
        self.subTotal = subTotal
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func calculateAndReturnDiscount(promoValue: String, maxValue: String){
        let promoValue : Int = Int(promoValue)!
        let maxValue : Int = Int(maxValue)!
        var discountAmount : Int = (subTotal! * promoValue)/100
        if discountAmount > maxValue{
            discountAmount = maxValue
        }
        delegate!.confirmedVoucher(discountAmount: discountAmount)
    }
    
    @IBAction func voucherEditingEnd(_ sender: Any) {
        print("editing ended")
        let parameter = ["code":voucherTextField.text!]
        NetworkService.shared.requestVoucherVerify(param: parameter) { (response) in
            print(response)
            self.validVoucherMark.image = UIImage(named: "checkCircle24Px")
            self.validVoucherMark.isHidden = false
            self.calculateAndReturnDiscount(promoValue: response.data.promoValue, maxValue: response.data.maxValue)
        } onError: { (error) in
            debugPrint(error)
            self.validVoucherMark.image = UIImage(named: "cancel")
            self.validVoucherMark.isHidden = false
            self.delegate!.deniedVoucher()
        }
    }
}

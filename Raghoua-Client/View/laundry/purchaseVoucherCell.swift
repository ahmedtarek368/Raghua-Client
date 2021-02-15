//
//  purchaseVoucherCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/13/21.
//

import UIKit

class purchaseVoucherCell: UITableViewCell {

    @IBOutlet weak var voucherTextField: basicTextField!
    @IBOutlet weak var validVoucherMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        voucherTextField.isTransparentTextField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellView(){
        voucherTextField.isTransparentTextField()
    }

}

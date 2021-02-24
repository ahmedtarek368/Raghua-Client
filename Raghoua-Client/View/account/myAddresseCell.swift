//
//  myAddresseCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit

class myAddresseCell: UITableViewCell {

    @IBOutlet weak var addressType: basicLabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var detailedAddress: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if "lang".localized == "ar"{
            detailedAddress.textAlignment = .right
        }
    }
    
    func updateCell(address: addressesData){
        self.addressType.text = "\(address.addressType)"
        self.address.text = "\(address.address)"
        self.detailedAddress.text = "\(address.street) \(address.nearstPlace)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func optionsBtnPressed(_ sender: Any) {
    }
}

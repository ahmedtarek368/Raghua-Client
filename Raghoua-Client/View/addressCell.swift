//
//  addressCellTableViewCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/31/21.
//

import UIKit

class addressCell: UITableViewCell {
    
    @IBOutlet weak var radioButton: radioButton!
    @IBOutlet weak var addressType: basicLabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var detailedAddress: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isNotSelectedCell()
        if "lang".localized == "ar"{
            detailedAddress.textAlignment = .right
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            isSelectedCell()
        }else{
            isNotSelectedCell()
        }
    }
    
    func isSelectedCell(){
        radioButton.isSelectedRadioButton()
    }
    
    func isNotSelectedCell(){
        radioButton.notSelectedRadioButton()
    }

}

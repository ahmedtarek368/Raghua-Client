//
//  laundriesOrderCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/8/21.
//

import UIKit

class laundriesOrderCell: UITableViewCell {

    @IBOutlet weak var selectedMark: UIImageView!
    @IBOutlet weak var orderingType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            selectedMark.isHidden = false
        }else{
            selectedMark.isHidden = true
        }
    }
    
    func updateCell(orderingType: String){
        self.orderingType.text = orderingType
    }

}

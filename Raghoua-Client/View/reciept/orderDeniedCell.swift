//
//  orderDenieCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit

class orderDenieCell: UITableViewCell {

    @IBOutlet weak var mainRoundedOrderView: UIView!
    @IBOutlet weak var statusMessageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        statusMessageView.layer.cornerRadius = 8
        mainRoundedOrderView.layer.cornerRadius = 12
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

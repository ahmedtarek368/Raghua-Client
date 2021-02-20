//
//  creditPayCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit

class creditPayCell: UITableViewCell {

    @IBOutlet weak var mainRoundedView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var payBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainRoundedView.layer.cornerRadius = 12
        statusView.layer.cornerRadius = 8
        customizePayBtn()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func customizePayBtn(){
        payBtn.layer.shadowRadius = 3
        payBtn.layer.shadowOpacity = 1
        payBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        payBtn.layer.shadowColor = #colorLiteral(red: 0.9568627451, green: 0.4117647059, blue: 0.2745098039, alpha: 0.5)
        payBtn.layer.masksToBounds = false
        payBtn.layer.cornerRadius = 12
    }
    
}

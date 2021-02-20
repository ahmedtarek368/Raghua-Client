//
//  accountSettingsCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/19/21.
//

import UIKit

class accountSettingsCell: UITableViewCell {

    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingTitle: basicLabel!
    @IBOutlet weak var settingSubTitle: basicLabel!
    @IBOutlet weak var settingMiniView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCell(settingTitle: String, settingImage: String){
        self.settingTitle.text = settingTitle
        self.settingImage.image = UIImage(named: "\(settingImage)")
    }
    
    func showSubTitle(content: String){
        settingSubTitle.isHidden = false
        settingSubTitle.text = content
    }
    func showMiniView(content: String){
        settingMiniView.isHidden = false
        settingMiniView.text = content
    }
}

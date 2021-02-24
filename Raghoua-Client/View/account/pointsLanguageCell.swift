//
//  pointsLanguageCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/23/21.
//

import UIKit

class pointsLanguageCell: UITableViewCell {

    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingTitle: basicLabel!
    @IBOutlet weak var settingMiniView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateCell(settingTitle: String, settingImage: String, miniView: String){
        self.settingTitle.text = settingTitle
        self.settingImage.image = UIImage(named: "\(settingImage)")
        self.settingMiniView.text = miniView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

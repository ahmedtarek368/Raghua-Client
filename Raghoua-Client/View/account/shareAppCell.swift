//
//  shareAppCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/23/21.
//

import UIKit

class shareAppCell: UITableViewCell {

    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingTitle: basicLabel!
    @IBOutlet weak var settingSubtitle: basicLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func updateCell(settingTitle: String, settingSubtitle: String, settingImage: String){
        self.settingTitle.text = settingTitle
        self.settingImage.image = UIImage(named: "\(settingImage)")
        self.settingSubtitle.text = settingSubtitle
    }

}

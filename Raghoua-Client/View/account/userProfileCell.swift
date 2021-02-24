//
//  userProfileCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/23/21.
//

import UIKit

class userProfileCell: UITableViewCell {

    @IBOutlet weak var userName: basicLabel!
    @IBOutlet weak var userMobileNumber: basicLabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(userImageUrl: String, userName: String, userMobileNumber: String){
        self.userName.text = userName
        self.userMobileNumber.text = userMobileNumber
        let imgUrl = NSURL(string: userImageUrl)! as URL
        self.userImage.sd_setImage(with: imgUrl, completed: nil)
    }

}

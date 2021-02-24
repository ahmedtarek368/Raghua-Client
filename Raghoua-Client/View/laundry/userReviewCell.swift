//
//  userReviewCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/10/21.
//

import UIKit
import SwiftyStarRatingView

class userReviewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: basicLabel!
    @IBOutlet weak var userReview: basicLabel!
    @IBOutlet weak var starRateView: SwiftyStarRatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if "lang".localized == "ar"{
            starRateView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        userImage.layer.cornerRadius = userImage.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(userImageUrl: String, userName: String, userComment: String){
        self.userName.text = userName
        self.userReview.text = userComment
        let imgUrl = NSURL(string: "\(userImageUrl)")! as URL
        userImage.sd_setImage(with: imgUrl, completed: nil)
    }

}

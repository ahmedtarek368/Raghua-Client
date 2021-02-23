//
//  waitingRateOrderCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/21/21.
//

import UIKit
import SwiftyStarRatingView

class waitingRateOrderCell: UITableViewCell {

    var delegate : reloadData?
    
    @IBOutlet weak var addRate: basicLabel!
    @IBOutlet weak var rateImpression: UIView!
    @IBOutlet weak var impressionMessage: UILabel!
    @IBOutlet weak var starRate: SwiftyStarRatingView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var totalCost: basicLabel!
    @IBOutlet weak var servicesQuantity: basicLabel!
    @IBOutlet weak var orderDate: basicLabel!
    @IBOutlet weak var orderNumber: basicLabel!
    @IBOutlet weak var orderStatus: basicLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if "lang".localized == "ar" {
            starRate.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        rateView.layer.cornerRadius = 20
        rateView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        rateImpression.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didChangeRateValue(_ sender: Any) {
        rateImpression.isHidden = false
        delegate!.reloadData()
//        starRate.emptyStarImage = UIImage(named: "starEmp24Px")
//        starRate.filledStarImage = UIImage(named: "starfill24Px")
//        starRate.spacing = 0
        if starRate.value == 0 {
            rateImpression.isHidden = true
            delegate!.reloadData()
        }else if starRate.value > 0 && starRate.value <= 1 {
            impressionMessage.text = "SoBad".localized
        }else if starRate.value > 1 && starRate.value <= 2 {
            impressionMessage.text = "Poor".localized
        }else if starRate.value > 2 && starRate.value <= 3 {
            impressionMessage.text = "NotBad".localized
        }else if starRate.value > 3 && starRate.value <= 4 {
            impressionMessage.text = "Good Laundry".localized
        }else if starRate.value > 4 && starRate.value <= 5 {
            impressionMessage.text = "Excellent Laundry".localized
        }
    }
}

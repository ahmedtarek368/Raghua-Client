//
//  laundriesCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/7/21.
//

import UIKit

class laundriesCell: UITableViewCell {

    
    @IBOutlet weak var laundryImage: UIImageView!
    @IBOutlet weak var laundryName: UILabel!
    @IBOutlet weak var minimumPricePerOrder: UILabel!
    @IBOutlet weak var orderFees: UILabel!
    @IBOutlet weak var laundryRate: UILabel!
    @IBOutlet weak var rateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateView.layer.cornerRadius = 14
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(laundryImageUrl: String, laundryName: String, laundryRate: Int, minimumPrice: String, deliveryPrice: String){
        self.laundryName.text = laundryName
        self.laundryRate.text = "\(laundryRate)"
        self.minimumPricePerOrder.text = minimumPrice
        self.orderFees.text = deliveryPrice
        do{
            self.laundryImage.image = try UIImage(data: Data(contentsOf: NSURL(string: "\(laundryImageUrl)")! as URL))
        }catch{}
    }

    
}

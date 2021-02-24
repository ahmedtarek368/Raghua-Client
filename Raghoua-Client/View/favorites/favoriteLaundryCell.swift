//
//  favoriteLaundryCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/19/21.
//

import UIKit

class favoriteLaundryCell: UITableViewCell {

    @IBOutlet weak var laundryImage: UIImageView!
    @IBOutlet weak var laundryName: UILabel!
    @IBOutlet weak var minimumPricePerOrder: UILabel!
    @IBOutlet weak var orderFees: UILabel!
    @IBOutlet weak var laundryRate: UILabel!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var removeBtn: UIButton!
    
    var delegate: updateFavorites?
    var viewDelegate: UIViewController?
    var laundryId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        rateView.layer.cornerRadius = 14
        removeBtn.layer.cornerRadius = 8
        removeBtn.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupAlert(title: String, message: String){
        let successfulAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        successfulAlert.addAction(UIAlertAction(title: "Ok", style: .cancel , handler: nil))
        viewDelegate!.present(successfulAlert, animated: true, completion: nil)
    }
    
    @IBAction func removeFavoriteBtnPressed(_ sender: Any) {
        let parameter = ["laundary_id":"\(self.laundryId!)", "status":"0"]
        NetworkService.shared.requestSetUnsetFavorite(param: parameter) { (response) in
            self.delegate!.updateFavorites()
        } onError: { (error) in
            self.setupAlert(title: "fail".localized, message: error)
        }
    }
    
    func updateCell(laundryId: Int, laundryImageUrl: String, laundryName: String, laundryRate: Int, minimumPrice: String, deliveryPrice: Int){
        self.laundryId = laundryId
        self.laundryName.text = laundryName
        self.laundryRate.text = "\(laundryRate)"
        self.minimumPricePerOrder.text = minimumPrice
        self.orderFees.text = "\(deliveryPrice)"
        let imgUrl = NSURL(string: laundryImageUrl)! as URL
        laundryImage.sd_setImage(with: imgUrl, completed: nil)
    }
}

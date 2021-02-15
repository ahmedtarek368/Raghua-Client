//
//  laundryRateReviewsVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/10/21.
//

import UIKit
import Lottie
import SwiftyStarRatingView

class laundryRateReviewsVC: UIViewController {

    @IBOutlet weak var rateValueView: UIView!
    @IBOutlet weak var totalRateValue: UILabel!
    @IBOutlet weak var starRateView: SwiftyStarRatingView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var totalRatesCount: basicLabel!
    @IBOutlet weak var userReviewsTV: UITableView!
    @IBOutlet weak var excellentBar: UIProgressView!
    @IBOutlet weak var excellentPercentage: UILabel!
    @IBOutlet weak var goodBar: UIProgressView!
    @IBOutlet weak var goodPercentage: UILabel!
    @IBOutlet weak var mediumBar: UIProgressView!
    @IBOutlet weak var mediumPercentage: UILabel!
    @IBOutlet weak var lessThanMediumBar: UIProgressView!
    @IBOutlet weak var lessThanMediumPercentage: UILabel!
    @IBOutlet weak var badBar: UIProgressView!
    @IBOutlet weak var badPercentage: UILabel!
    
    var reviewsData: ReviewsData?
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
            starRateView.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        }
        rateValueView.layer.cornerRadius = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userReviewsTV.delegate = self
        userReviewsTV.dataSource = self
        userReviewsTV.tableFooterView = UIView()
        setupReviews()
    }
    
    func setupReviews(){
        excellentBar.setProgress(Float(reviewsData!.excelent), animated: false)
        goodBar.setProgress(Float(reviewsData!.good), animated: false)
        mediumBar.setProgress(Float(reviewsData!.medium), animated: false)
        lessThanMediumBar.setProgress(Float(reviewsData!.lessMedium), animated: false)
        badBar.setProgress(Float(reviewsData!.dataWeak), animated: false)
        totalRateValue.text = "\(reviewsData!.totalRate)"
        starRateView.value = CGFloat(reviewsData!.totalRate)
        totalRatesCount.text = "التقييم بناءا على \(reviewsData!.commnetCount) تقييم"
        excellentPercentage.text = "\(reviewsData!.excelent)%"
        goodPercentage.text = "\(reviewsData!.good)%"
        mediumPercentage.text = "\(reviewsData!.medium)%"
        lessThanMediumPercentage.text = "\(reviewsData!.lessMedium)%"
        badPercentage.text = "\(reviewsData!.dataWeak)%"
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

}

extension laundryRateReviewsVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsData!.allReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userReviewCell : userReviewCell = tableView.dequeueReusableCell(withIdentifier: "URC", for: indexPath) as! userReviewCell
        let review =  reviewsData!.allReviews[indexPath.row]
        userReviewCell.updateCell(userImageUrl: review.userImg, userName: review.userName, userComment: review.comment)
        print(review.userImg)
        return userReviewCell
    }
    
    
}

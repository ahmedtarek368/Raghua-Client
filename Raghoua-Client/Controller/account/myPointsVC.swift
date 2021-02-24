//
//  myPointsVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/20/21.
//

import UIKit

class myPointsVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var myPoints: UILabel!
    
    var points: String?
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
        myPoints.text = points!
    }
    
    func initPoints(userPoints:String){
        self.points = userPoints
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func getDiscountBtnPressed(_ sender: Any) {
        
    }
    
}

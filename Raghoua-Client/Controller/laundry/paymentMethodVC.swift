//
//  paymentMethodVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/15/21.
//

import UIKit

class paymentMethodVC: UIViewController {

    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var totalPrice: basicLabel!
    @IBOutlet weak var paymentMethodTV: UITableView!
    @IBOutlet weak var continueBtn: basicShadowedBtn!
    
    var methodIndex: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
        continueBtn.isLockedButton()
        continueBtn.isUserInteractionEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentMethodTV.delegate = self
        paymentMethodTV.dataSource = self
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        self.popBack(2)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        if #available(iOS 13.0, *) {
            let outOfWorkingHoursWarning = self.storyboard?.instantiateViewController(identifier: "OOWHWVC") as! outOfWorkingHoursWarningVC
            self.present(outOfWorkingHoursWarning, animated: true, completion: nil)
        } else {
            let outOfWorkingHoursWarning = self.storyboard?.instantiateViewController(withIdentifier: "OOWHWVC") as! outOfWorkingHoursWarningVC
            self.present(outOfWorkingHoursWarning, animated: true, completion: nil)
        }
        
    }
    
}

extension paymentMethodVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let methodCell : paymentMethodsCell = tableView.dequeueReusableCell(withIdentifier: "PMC") as! paymentMethodsCell
        methodCell.updateCell(methodName: "نقدي عند الاستلام", methodImage: "monetizationOn24Px-1")
        if indexPath.row == 1{
            methodCell.setPaymentOnDeliverlabel()
            methodCell.updateCell(methodName: "بطاقة ائتمان", methodImage: "creditCard24Px")
            return methodCell
        }
        return methodCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        continueBtn.isUnlockedButton()
        continueBtn.isUserInteractionEnabled = true
        let methodCell : paymentMethodsCell = tableView.cellForRow(at: indexPath) as! paymentMethodsCell
        self.methodIndex = indexPath.row
        methodCell.setSelected(true, animated: true)
    }
    
}

//
//  reorderingLaundriesPopupVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/8/21.
//

import UIKit
import BottomPopup

class reorderingLaundriesPopupVC: BottomPopupViewController, BottomPopupDelegate {

    let ordersArr : [String] = ["nearest".localized,"highly rated".localized,"fastest delivery".localized]
    
    @IBOutlet weak var orderTVC: UITableView!
    override var popupShouldDismissInteractivelty: Bool{
        return true
    }
    override var popupHeight: CGFloat{
        return UIScreen.main.bounds.size.height/2.9
    }
    override var popupTopCornerRadius: CGFloat{
        return 25
    }
    override var popupPresentDuration: Double{
        return 0.3
    }
    override var popupDismissDuration: Double{
        return 0.3
    }
    override var popupDimmingViewAlpha: CGFloat{
        return 0.15
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupDelegate = self
        orderTVC.delegate = self
        orderTVC.dataSource = self
    }


}

extension reorderingLaundriesPopupVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ordersArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : laundriesOrderCell = tableView.dequeueReusableCell(withIdentifier: "LOC", for: indexPath) as! laundriesOrderCell
        cell.updateCell(orderingType: ordersArr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : laundriesOrderCell = tableView.cellForRow(at: indexPath) as! laundriesOrderCell
        cell.setSelected(true, animated: true)
    }
    
    
}

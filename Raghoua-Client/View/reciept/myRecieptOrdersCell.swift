//
//  myRecieptOrdersCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/21/21.
//

import UIKit

class myRecieptOrdersCell: UITableViewCell {

    @IBOutlet weak var ordersTV: UITableView!
    let sectionTitles : [String] = ["","order details".localized,"your order".localized]
    
    var orderDetails: OrderDetails?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ordersTV.delegate = self
        ordersTV.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateCell(orderDetails: OrderDetails){
        self.orderDetails = orderDetails
        ordersTV.reloadData()
    }

}

extension myRecieptOrdersCell: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let orderDetails = self.orderDetails{
            return orderDetails.items.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "H")!
        let orderDetails = self.orderDetails
        let item = orderDetails?.items[section]
        let headerTitle : UILabel = header.viewWithTag(1) as! UILabel
        headerTitle.text = item?.name
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let orderDetails = self.orderDetails{
            return orderDetails.items[section].services.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : orderItemCell = tableView.dequeueReusableCell(withIdentifier: "MO") as! orderItemCell
        let orderDetails = self.orderDetails
        let item = orderDetails?.items[indexPath.section]
        let service = item?.services[indexPath.row]
        cell.updateCell(service: service!)
        return cell
    }
    
}

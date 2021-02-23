//
//  myOrdersCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/12/21.
//

import UIKit

class myOrdersCell: UITableViewCell{

    @IBOutlet weak var ordersTV: UITableView!
    
    var userCart: UserCart?
    var delegate: updateCartView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ordersTV.delegate = self
        ordersTV.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateCell(userCart: UserCart){
        self.userCart = userCart
        ordersTV.reloadData()
    }

}

extension myOrdersCell : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let itemsCount = self.userCart?.items.count{
            return itemsCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 51
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "OTC")
        let headerTitle : UILabel = header?.viewWithTag(3) as! UILabel
        if let item = self.userCart?.items[section]{
            headerTitle.text = item.name
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let item = self.userCart?.items[section]{
            return item.services.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderDetailsCell : cartUserItemCell = tableView.dequeueReusableCell(withIdentifier: "ODC", for: indexPath) as! cartUserItemCell
        orderDetailsCell.delegate = self
        orderDetailsCell.updateCell(userCart: userCart!, itemIndex: indexPath.section, serviceIndex: indexPath.row)
        return orderDetailsCell
    }
    
}

extension myOrdersCell: updateUserCart{
    
    func updateUserCart(userCart: UserCart) {
        self.userCart = userCart
        self.ordersTV.reloadData()
        delegate!.updateCart(userCart: userCart)
    }
    
    func removeAndReloadTable(userCart: UserCart) {
        self.userCart = userCart
        self.ordersTV.reloadData()
        self.delegate?.updateCellHeight(userCart: userCart)
    }
    
}

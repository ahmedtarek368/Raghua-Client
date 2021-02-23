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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ordersTV.delegate = self
        ordersTV.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension myRecieptOrdersCell: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 57
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "H")!
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MO")!
        return cell
    }
    
}

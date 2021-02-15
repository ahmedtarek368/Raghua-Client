//
//  myOrdersCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/12/21.
//

import UIKit

class myOrdersCell: UITableViewCell {

    @IBOutlet weak var ordersTV: UITableView!
    
    var title = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ordersTV.delegate = self
        ordersTV.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setSectionHeaderTitle(title: [String]){
        self.title = title
    }

}

extension myOrdersCell : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
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
        headerTitle.text = self.title[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let orderDetailsCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "ODC", for: indexPath)
        return orderDetailsCell
    }
    
    
}

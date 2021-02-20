//
//  orderDetailsVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/18/21.
//

import UIKit

class orderDetailsVC: UIViewController {

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var orderBriefTV: UITableView!
    
    var cellNibName: String?
    var reuseId: String?
    
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderBriefTV.delegate = self
        orderBriefTV.dataSource = self
        orderBriefTV.register(UINib(nibName: "\(cellNibName!)", bundle: nil), forCellReuseIdentifier: "\(reuseId!)")
        orderBriefTV.register(UINib(nibName: "orderDetailsCell", bundle: nil), forCellReuseIdentifier: "RODC")
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        
    }

}

extension orderDetailsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "\(reuseId!)", for: indexPath)
            return cell
        }else {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "RODC", for: indexPath)
            return cell
        }
    }
    
    
}

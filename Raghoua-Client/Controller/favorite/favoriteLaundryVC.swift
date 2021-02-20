//
//  favoriteLaundryVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/19/21.
//

import UIKit

class favoriteLaundryVC: UIViewController {

    @IBOutlet weak var favoritesTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTV.delegate = self
        favoritesTV.dataSource = self
    }

}

extension favoriteLaundryVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : favoriteLaundryCell = tableView.dequeueReusableCell(withIdentifier: "FLC", for: indexPath) as! favoriteLaundryCell
        return cell
    }
    
    
}

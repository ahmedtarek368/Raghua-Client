//
//  laundriesVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/6/21.
//

import UIKit

class laundriesVC: UIViewController {

    @IBOutlet weak var laundriesTVC: UITableView!
    @IBOutlet weak var reorderBtn: basicBlueShadowedBtn!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.layer.shadowOffset = CGSize(width: 0, height: 7)
        self.tabBarController?.tabBar.layer.shadowRadius = 9
        self.tabBarController?.tabBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.tabBarController?.tabBar.layer.shadowOpacity = 0.2
        self.tabBarController?.tabBar.layer.masksToBounds = false
        self.tabBarController?.tabBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.tabBarController?.tabBar.backgroundImage = UIImage()
        self.tabBarController?.tabBar.shadowImage = UIImage()
        self.tabBarController?.tabBar.isTranslucent = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laundriesTVC.delegate = self
        laundriesTVC.dataSource = self
        reorderBtn.isCircleButton()
        
    }
    
    @IBAction func reorderBtnPressed(_ sender: Any) {
        
    }
    
}

extension laundriesVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LC", for: indexPath) as! laundriesCell
        return cell
    }
    
    
    
    
}

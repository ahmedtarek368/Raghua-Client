//
//  myOrdersVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/17/21.
//

import UIKit

class myOrdersVC: UIViewController {

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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

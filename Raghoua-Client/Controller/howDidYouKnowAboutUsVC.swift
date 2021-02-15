//
//  howDidYouKnowAboutUsVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/30/21.
//

import UIKit
import BottomPopup


@available(iOS 13.0, *)
class howDidYouKnowAboutUsVC: UIViewController {
    
    var user: User = User()
    @IBOutlet weak var bottomPopupView: bottomPopupView!
    @IBOutlet weak var choicesTV: UITableView!
    let choices : [String] = ["from advertisement".localized,"from social media".localized,"a friend told me".localized]
    
    //let choicesEn : [String] = ["from addvertisement","a friend told me","from social media"]
    
    override func viewDidLayoutSubviews() {
        bottomPopupView.setBottomPopupHeight(height: Float(UIScreen.main.bounds.size.height/4.98))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow_back_\("lang".localized)"), style: .plain, target: self, action: #selector(backBtnPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        choicesTV.delegate = self
        choicesTV.dataSource = self
        choicesTV.tableFooterView =  UIView()
    }
    
    @objc func backBtnPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        let addressesListView : addressesListVC = self.storyboard?.instantiateViewController(identifier: "ALVC") as! addressesListVC
        addressesListView.user = self.user
        self.navigationController?.pushViewController(addressesListView, animated: true)
    }
}

@available(iOS 13.0, *)
extension howDidYouKnowAboutUsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : choicesCell = tableView.dequeueReusableCell(withIdentifier: "CC", for: indexPath) as! choicesCell
        cell.initializeCell(choiceText: choices[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell : choicesCell = tableView.cellForRow(at: indexPath) as! choicesCell
        cell.setSelected(true, animated: true)
    }
    
    
}

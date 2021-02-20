//
//  accountSettingsVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/19/21.
//

import UIKit

class accountSettingsVC: UIViewController {

    @IBOutlet weak var accountSettingsTV: UITableView!
    
    let sectionsTitles : [String] = ["my account".localized,"settings".localized,"raghua".localized]
    let accountTitles : [String] = ["my points".localized, "addresses list".localized]
    let settingTitle : String = "language".localized
    let raghuaTitles : [String] = ["about app".localized, "usage policy".localized, "call us".localized, "facebook".localized, "twitter".localized, "instagram".localized, "share app".localized]
    let signOutTitle : String = "sign out".localized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountSettingsTV.delegate = self
        accountSettingsTV.dataSource = self
    }

}

extension accountSettingsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 3 {
            return 59
        }else if section == 3{
            return 16
        }else{
            return 135
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section < 3 {
            let header = tableView.dequeueReusableCell(withIdentifier: "TH")
            let headerTitle : UILabel = header?.viewWithTag(2) as! UILabel
            headerTitle.text = sectionsTitles[section]
            return header
        }else if section == 3{
            let header = tableView.dequeueReusableCell(withIdentifier: "SH")
            return header
        }else{
            let header = tableView.dequeueReusableCell(withIdentifier: "DBATIAF")
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }else if section == 1{
            return 1
        }else if section == 2 {
            return 7
        }else if section == 3{
            return 1
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountSettingsCell : accountSettingsCell = tableView.dequeueReusableCell(withIdentifier: "ASC", for: indexPath) as! accountSettingsCell
        
        if indexPath.section == 0 {
            accountSettingsCell.updateCell(settingTitle: accountTitles[indexPath.row], settingImage: "\(indexPath.row)account")
        }else if indexPath.section == 1{
            accountSettingsCell.updateCell(settingTitle: settingTitle, settingImage: "\(indexPath.row)settings")
        }else if indexPath.section == 2{
            accountSettingsCell.updateCell(settingTitle: raghuaTitles[indexPath.row], settingImage: "\(indexPath.row)raghua")
        }else {
            accountSettingsCell.updateCell(settingTitle: signOutTitle, settingImage: "\(indexPath.row)exit")
        }
        
        if indexPath.section == 0 && indexPath.row == 0{
            accountSettingsCell.showMiniView(content: "50")
        }else if indexPath.section == 1 && indexPath.row == 0 {
            accountSettingsCell.showMiniView(content: "applanguage".localized)
        }else if indexPath.section == 2 && indexPath.row == 6 {
            accountSettingsCell.showSubTitle(content: "shareAcc".localized)
        }else if indexPath.section == 3 && indexPath.row == 0 {
            accountSettingsCell.settingMiniView.isHidden = true
        }
        return accountSettingsCell
    }
    
    
}

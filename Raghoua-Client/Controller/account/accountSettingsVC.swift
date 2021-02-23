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
        accountSettingsTV.contentInsetAdjustmentBehavior =  .never
    }

    func pushToUpdateInfo(){
        if #available(iOS 13.0, *) {
            let updateInfoView : updateInfoVC = self.storyboard?.instantiateViewController(identifier: "UIVC") as! updateInfoVC
            self.navigationController?.pushViewController(updateInfoView, animated: true)
        } else {
            let updateInfoView : updateInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "UIVC") as! updateInfoVC
            self.navigationController?.pushViewController(updateInfoView, animated: true)
        }
    }
    
    func pushToMyPointsVC(){
        if #available(iOS 13.0, *) {
            let myPointsView : myPointsVC = self.storyboard?.instantiateViewController(identifier: "MPVC") as! myPointsVC
            self.navigationController?.pushViewController(myPointsView, animated: true)
        } else {
            let myPointsView : myPointsVC = self.storyboard?.instantiateViewController(withIdentifier: "MPVC") as! myPointsVC
            self.navigationController?.pushViewController(myPointsView, animated: true)
        }
    }
    
    func pushToMyAddressesList(){
        if #available(iOS 13.0, *) {
            let myAddressesView : myAddressesVC = self.storyboard?.instantiateViewController(identifier: "MADVC") as! myAddressesVC
            self.navigationController?.pushViewController(myAddressesView, animated: true)
        } else {
            let myAddressesView : myAddressesVC = self.storyboard?.instantiateViewController(withIdentifier: "MADVC") as! myAddressesVC
            self.navigationController?.pushViewController(myAddressesView, animated: true)
        }
        
    }
    
    func pushToAboutApp(){
        if #available(iOS 13.0, *) {
            let aboutAppView : aboutAppVC = self.storyboard?.instantiateViewController(identifier: "AAVC") as! aboutAppVC
            self.navigationController?.pushViewController(aboutAppView, animated: true)
        } else {
            let aboutAppView : aboutAppVC = self.storyboard?.instantiateViewController(withIdentifier: "AAVC") as! aboutAppVC
            self.navigationController?.pushViewController(aboutAppView, animated: true)
        }
    }
    
    func pushToUsagePolicy(){
        if #available(iOS 13.0, *) {
            let usagePolicyView : usagePolicyVC = self.storyboard?.instantiateViewController(identifier: "UPOVC") as! usagePolicyVC
            self.navigationController?.pushViewController(usagePolicyView, animated: true)
        } else {
            let usagePolicyView : usagePolicyVC = self.storyboard?.instantiateViewController(withIdentifier: "UPOVC") as! usagePolicyVC
            self.navigationController?.pushViewController(usagePolicyView, animated: true)
        }
    }
    
    func pushToContactUs(){
        if #available(iOS 13.0, *) {
            let contactUsView : contactUsVC = self.storyboard?.instantiateViewController(identifier: "CCVC") as! contactUsVC
            self.navigationController?.pushViewController(contactUsView, animated: true)
        } else {
            let contactUsView : contactUsVC = self.storyboard?.instantiateViewController(withIdentifier: "CCVC") as! contactUsVC
            self.navigationController?.pushViewController(contactUsView, animated: true)
        }
    }
    
    
}

extension accountSettingsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }else if section > 0 && section < 4 {
            return 59
        }else if section == 4{
            return 16
        }else{
            return 215
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            let header = tableView.dequeueReusableCell(withIdentifier: "WC")
            return header
        }else if section > 0 && section < 4 {
            let header = tableView.dequeueReusableCell(withIdentifier: "TH")
            let headerTitle : UILabel = header?.viewWithTag(2) as! UILabel
            headerTitle.text = sectionsTitles[section-1]
            return header
        }else if section == 4{
            let header = tableView.dequeueReusableCell(withIdentifier: "SH")
            return header
        }else{
            let header = tableView.dequeueReusableCell(withIdentifier: "DBATIAF")
            return header
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else if section == 1 {
            return 2
        }else if section == 2{
            return 1
        }else if section == 3 {
            return 7
        }else if section == 4{
            return 1
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let accountSettingsCell : accountSettingsCell = tableView.dequeueReusableCell(withIdentifier: "ASC", for: indexPath) as! accountSettingsCell
        
        if indexPath.section == 0{
            let userProfileCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "UPC")!
            return userProfileCell
        }else if indexPath.section == 1 {
            accountSettingsCell.updateCell(settingTitle: accountTitles[indexPath.row], settingImage: "\(indexPath.row)account")
        }else if indexPath.section == 2{
            accountSettingsCell.updateCell(settingTitle: settingTitle, settingImage: "\(indexPath.row)settings")
        }else if indexPath.section == 3{
            accountSettingsCell.updateCell(settingTitle: raghuaTitles[indexPath.row], settingImage: "\(indexPath.row)raghua")
        }else {
            accountSettingsCell.updateCell(settingTitle: signOutTitle, settingImage: "\(indexPath.row)exit")
        }
        
        if indexPath.section == 1 && indexPath.row == 0{
            accountSettingsCell.showMiniView(content: "50")
        }else if indexPath.section == 2 && indexPath.row == 0 {
            accountSettingsCell.showMiniView(content: "applanguage".localized)
        }else if indexPath.section == 3 && indexPath.row == 6 {
            accountSettingsCell.showSubTitle(content: "shareAcc".localized)
        }
        return accountSettingsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0{
         pushToUpdateInfo()
        }else if indexPath.section == 1 && indexPath.row == 0{
         pushToMyPointsVC()
        }else if indexPath.section == 1 && indexPath.row == 1{
         pushToMyAddressesList()
        }else if indexPath.section == 2 && indexPath.row == 0{
            //ChangeLanguage
        }else if indexPath.section == 3 && indexPath.row == 0{
            pushToAboutApp()
        }else if indexPath.section == 3 && indexPath.row == 1{
            pushToUsagePolicy()
        }else if indexPath.section == 3 && indexPath.row == 2{
            pushToContactUs()
        }else if indexPath.section == 3 && indexPath.row == 3{
            //facebook
        }else if indexPath.section == 3 && indexPath.row == 4{
            //twitter
        }else if indexPath.section == 3 && indexPath.row == 5{
            //instagram
        }else if indexPath.section == 3 && indexPath.row == 6{
            //share the app
        }else if indexPath.section == 4 && indexPath.row == 0{
            //signout
        }
    }
    
}

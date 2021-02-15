//
//  aboutLaundryVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/10/21.
//

import UIKit

class aboutLaundryVC: UIViewController {

    @IBOutlet weak var aboutTV: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    var aboutLaundry: About?
    var index : Int = 0
    let titles : [String] = ["time to deliver".localized, "brief".localized, "location on map".localized, "work days".localized]
    let content = ["خلال ساعتين","هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ عن التركيز على الشكل الخارجي للنص أو شكل توضع الفقرات في الصفحة التي يقرأها","6739 الملوح بن ابي عامر، الروضة،، الرياض 13213 3467، السعودية","السبت 10:00 ص - 10:00 م\nالأحد 10:00 ص - 10:00 م\nالاثنين 10:00 ص - 10:00 م\nالثلاثاء 10:00 ص - 10:00 م\nالأربعاء 10:00 ص - 10:00 م"]
    override func viewWillAppear(_ animated: Bool) {
        if "lang".localized == "ar"{
            backBtn.setImage(UIImage(named: "arrowBackW24Px"), for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutTV.delegate = self
        aboutTV.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }

}

extension aboutLaundryVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "TH")
        let headerTitle : UILabel = header?.viewWithTag(1) as! UILabel
        headerTitle.text = titles[section]
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aboutCell : aboutCell = tableView.dequeueReusableCell(withIdentifier: "AC", for: indexPath) as! aboutCell
        if index == 0 {
            aboutCell.updateCell(content: self.aboutLaundry!.deliveryIn)
            index = index+1
            return aboutCell
        }else if index == 1 {
            aboutCell.updateCell(content: self.aboutLaundry!.about)
            index = index+1
            return aboutCell
        }else if index == 2 {
            aboutCell.updateCell(content: self.aboutLaundry!.lat)
            index = index+1
            return aboutCell
        }else{
            aboutCell.setWorkingDays(workingDays: self.aboutLaundry!.workDays)
            index = index+1
            return aboutCell
        }
    }
    
}

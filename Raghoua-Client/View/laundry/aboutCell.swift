//
//  aboutCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/10/21.
//

import UIKit

class aboutCell: UITableViewCell {

    @IBOutlet weak var sectionContent: basicLabel!
    var workingDays: [WorkDay]?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(content: String){
        self.sectionContent.text = content
    }
    
    func setWorkingDays(workingDays: [WorkDay]){
        self.workingDays = workingDays
        for i in 0..<workingDays.count{
            self.sectionContent.text = self.sectionContent.text! + "\(workingDays[i].dayName)\t\t\t\t\t\(workingDays[i].from)-\(workingDays[i].to)\n"
        }
    }

}

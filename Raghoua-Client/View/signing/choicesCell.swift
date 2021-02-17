//
//  choicesCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/31/21.
//

import UIKit

class choicesCell: UITableViewCell {

    @IBOutlet weak var radioButton: radioButton!
    @IBOutlet weak var choiceText: basicLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            isSelectedCell()
        }else{
            isNotSelectedCell()
        }
    }
    
    func initializeCell(choiceText: String){
        self.choiceText.text = choiceText
        isNotSelectedCell()
    }
    
    func isSelectedCell(){
        radioButton.isSelectedRadioButton()
    }
    
    func isNotSelectedCell(){
        radioButton.notSelectedRadioButton()
    }
}

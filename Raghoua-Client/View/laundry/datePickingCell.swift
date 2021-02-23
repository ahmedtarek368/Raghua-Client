//
//  datePickingCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/22/21.
//

import UIKit

class datePickingCell: UITableViewCell {

    @IBOutlet weak var specifyTime: basicTextField!
    @IBOutlet weak var specifyDate: basicTextField!
    
    var cellIndex : Int?

    let specifyDatePicker = UIDatePicker()
    let specifyTimePicker = UIDatePicker()
    
    var delegate: confirmDeliverRecieveDateTime?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createDatePicker()
        createTimePicker()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        specifyTime.isTransparentTextField()
        specifyDate.isTransparentTextField()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func createDatePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePickingDatePressed(sender:)))
        toolBar.setItems([doneBtn], animated: true)
        
        specifyDate.inputAccessoryView = toolBar
        specifyDate.inputView = specifyDatePicker
        specifyDatePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            specifyDatePicker.preferredDatePickerStyle = .wheels
        } else {}
        
    }
    
    func createTimePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePickingTimePressed(sender:)))
        toolBar.setItems([doneBtn], animated: true)
        
        specifyTime.inputAccessoryView = toolBar
        specifyTime.inputView = specifyTimePicker
        specifyTimePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            specifyTimePicker.preferredDatePickerStyle = .wheels
        } else {}
    }
    
    @objc func donePickingDatePressed(sender: UIBarButtonItem){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        specifyDate.textAlignment = .center
        specifyDate.text = dateFormatter.string(from: specifyDatePicker.date)
        if self.cellIndex == 1 {//delivery
            delegate?.confirmDeliverDate(date: specifyDate.text!)
        }else{//receive
            delegate?.confirmRecieveDate(date: specifyDate.text!)
        }
        endEditing(true)
    }
    
    @objc func donePickingTimePressed(sender: UIBarButtonItem){
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .medium
        timeFormatter.dateStyle = .none
        specifyTime.textAlignment = .center
        specifyTime.text = timeFormatter.string(from: specifyTimePicker.date)
        if self.cellIndex == 1 {//delivery
            delegate?.confirmDeliverTime(time: specifyTime.text!)
        }else{//receive
            delegate?.confirmRecieveTime(time: specifyTime.text!)
        }
        endEditing(true)
    }
    
}

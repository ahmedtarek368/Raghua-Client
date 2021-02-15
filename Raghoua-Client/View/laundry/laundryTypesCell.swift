//
//  laundryTypesCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/9/21.
//

import UIKit

class laundryTypesCell: UICollectionViewCell {
    
    @IBOutlet weak var laundryType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
                isSelectedCell()
            }else{
                isNotSelectedCell()
            }
        }
    }
    
    func updateCell(laundryType: String){
        self.laundryType.text = laundryType
    }
    
    func isSelectedCell(){
        self.backgroundColor = #colorLiteral(red: 0.1411764706, green: 0.2274509804, blue: 0.5607843137, alpha: 1)
        laundryType.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        laundryType.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    func isNotSelectedCell(){
        self.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.9725490196, alpha: 1)
        laundryType.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        laundryType.textColor = #colorLiteral(red: 0.6274509804, green: 0.6392156863, blue: 0.6549019608, alpha: 1)
    }
    
}

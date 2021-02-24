//
//  clothesCell.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/9/21.
//

import UIKit

class itemsCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var servicesCV: UICollectionView!
    var services: [Catgory]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        servicesCV.delegate = self
        servicesCV.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(itemImageUrl: String, itemName: String,services: [Catgory]){
        self.services = services
        self.itemName.text = itemName
        let imgUrl = NSURL(string: itemImageUrl)! as URL
        itemImage.sd_setImage(with: imgUrl, completed: nil)

    }

}

extension itemsCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return services!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let serviceCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SC", for: indexPath)
        let service = self.services![indexPath.row]
        let serviceName : UILabel = serviceCell.viewWithTag(1) as! UILabel
        let servicePrice : UILabel = serviceCell.viewWithTag(2) as! UILabel
        serviceName.text = service.name
        servicePrice.text = service.price
        return serviceCell
    }
    
    
}

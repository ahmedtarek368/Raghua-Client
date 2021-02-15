//
//  orderPerItemVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/10/21.
//

import UIKit

@available(iOS 13.0, *)
class orderItemVC: UIViewController {
    
    @IBOutlet weak var orderServicesTV: UITableView!
    @IBOutlet weak var exitBtn: basicShadowedBtn!
    @IBOutlet weak var itemName: basicLabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var bottomPopupView: bottomPopupView!
    @IBOutlet weak var showBasketBtn: basicShadowedBtn!
    @IBOutlet weak var itemsInBasket: UILabel!

    
    var item: Item?
    
    override func viewDidLayoutSubviews() {
        bottomPopupView.setBottomPopupHeight(height: Float(UIScreen.main.bounds.size.height/1.4))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLayout()
        setupItemData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderServicesTV.delegate = self
        orderServicesTV.dataSource = self
    }
    
    func setupLayout(){
        bottomPopupView.setBottomPopupHeight(height: Float(UIScreen.main.bounds.size.height/3))
        exitBtn.isWhiteCircleButton()
        itemsInBasket.layer.borderWidth = 2
        itemsInBasket.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        itemsInBasket.layer.cornerRadius = itemsInBasket.frame.size.height/2
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupItemData(){
        self.itemName.text = item!.name
        do{
            self.itemImage.image = try UIImage(data: Data(contentsOf: NSURL(string: "\(item!.img)")! as URL))
        }catch{}
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showBasketBtnPressed(_ sender: Any) {
        let shoppingBasketView : shoppingBasketVC = self.storyboard?.instantiateViewController(identifier: "SBVC") as! shoppingBasketVC
        self.navigationController?.pushViewController(shoppingBasketView, animated: true)
    }
    
}

@available(iOS 13.0, *)
extension orderItemVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.item!.priceMethod == 2 {
            return 165
        }
        return 112
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item!.services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.item!.priceMethod == 2 {
            let itemSizeCell : itemSizeCell = tableView.dequeueReusableCell(withIdentifier: "SOC2") as! itemSizeCell
        itemSizeCell.delegate = self
        itemSizeCell.sizeDelegate = self
            let service = item!.services[indexPath.row]
        itemSizeCell.updateCell(serviceName: service.name, servicePrice: service.price!)
            return itemSizeCell
        }else{
            let serviceOrderCell : serviceOrderCell = tableView.dequeueReusableCell(withIdentifier: "SOC") as! serviceOrderCell
            let service = item!.services[indexPath.row]
            serviceOrderCell.delegate = self
            serviceOrderCell.updateCell(serviceName: service.name, servicePrice: service.price!)
            return serviceOrderCell
        }
    }
}

@available(iOS 13.0, *)
extension orderItemVC: orderQuantity{
    func increaseQuantity() {
        let quantity : Int = Int(itemsInBasket.text!)!
        itemsInBasket.text = "\(quantity+1)"
    }
    
    func decreaseQuantity() {
        let quantity : Int = Int(itemsInBasket.text!)!
        if quantity != 0 {
            itemsInBasket.text = "\(quantity-1)"
        }
    }
}

@available(iOS 13.0, *)
extension orderItemVC: orderSize{
    func increaseSize() {
    }
    
    func decreaseSize() {
    }
}

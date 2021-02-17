//
//  orderPerItemVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/10/21.
//

import UIKit

class orderItemVC: UIViewController {
    
    @IBOutlet weak var orderServicesTV: UITableView!
    @IBOutlet weak var exitBtn: basicShadowedBtn!
    @IBOutlet weak var itemName: basicLabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var bottomPopupView: bottomPopupView!
    @IBOutlet weak var showBasketBtn: basicShadowedBtn!
    @IBOutlet weak var itemsInBasket: UILabel!
    @IBOutlet weak var totalOrderPrice: UILabel!
    
    var item: Item?
    var order: [String:String]?
    var userCartID: Int?
    
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
        requestUserCart()
    }
    
    func requestUserCart(){
        NetworkService.shared.requestUserCartData { (response) in
            self.pushToCartVC(userCart: response.data)
        } onError: { (error) in
            debugPrint(error)
        }
    }
    
    func pushToCartVC(userCart: UserCart){
        if #available(iOS 13.0, *) {
            let shoppingBasketView : shoppingBasketVC = self.storyboard?.instantiateViewController(identifier: "SBVC") as! shoppingBasketVC
            let cellHeight = calculateItemsServicesNumber(userCart: userCart)
            shoppingBasketView.userCart = userCart
            shoppingBasketView.ordersCellHeight = cellHeight
            self.navigationController?.pushViewController(shoppingBasketView, animated: true)
        } else {
            let shoppingBasketView : shoppingBasketVC = self.storyboard?.instantiateViewController(withIdentifier: "SBVC") as! shoppingBasketVC
            let cellHeight = calculateItemsServicesNumber(userCart: userCart)
            shoppingBasketView.userCart = userCart
            shoppingBasketView.ordersCellHeight = cellHeight
            self.navigationController?.pushViewController(shoppingBasketView, animated: true)
        }
    }
    
    func calculateItemsServicesNumber(userCart: UserCart) -> Int {
        let itemsCount : Int = userCart.items.count
        var cellHeight : Int = 0
        let itemHeight : Int = 51
        let serviceHeight : Int = 82
        for i in 0..<itemsCount{
            cellHeight = cellHeight + itemHeight
            let servicesCount : Int = userCart.items[i].services.count
            for _ in 0..<servicesCount {
                cellHeight = cellHeight + serviceHeight
            }
        }
        return cellHeight
    }
    
}

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
            itemSizeCell.updateCell(item: item!, serviceIndex: indexPath.row, userCartID: userCartID!)
            return itemSizeCell
        }else{
            let serviceOrderCell : serviceOrderCell = tableView.dequeueReusableCell(withIdentifier: "SOC") as! serviceOrderCell
            serviceOrderCell.delegate = self
            serviceOrderCell.updateCell(item: item!, serviceIndex: indexPath.row, userCartID: userCartID!)
            return serviceOrderCell
        }
    }
}

extension orderItemVC: orderQuantity{
    func increaseQuantity(serviceIndex: Int) {
        let quantity : Int = Int(itemsInBasket.text!)!
        self.itemsInBasket.text = "\(quantity+1)"
        let price = Int((self.item?.services[serviceIndex].price)!)
        self.totalOrderPrice.text = "\(price!*(quantity+1)) ريال"
        
    }
    
    func decreaseQuantity(serviceIndex: Int) {
        let quantity : Int = Int(itemsInBasket.text!)!
        if quantity != 0 {
            itemsInBasket.text = "\(quantity-1)"
            let price = Int((self.item?.services[serviceIndex].price)!)
            totalOrderPrice.text = "\(price!*(quantity-1)) ريال"
        }
    }
}

extension orderItemVC: orderSize{
    func increaseSize() {
    }
    
    func decreaseSize() {
    }
}

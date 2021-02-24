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
    //var order: [String:String]?
    var userCartID: Int?
    var userCart: UserCart?
    var minimumPrice: Int?
    var order = Order()
    
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
        updateCartInfo(userCart: userCart!)
    }
    
    func setupLayout(){
        bottomPopupView.setBottomPopupHeight(height: Float(UIScreen.main.bounds.size.height/3))
        exitBtn.isWhiteCircleButton()
        itemsInBasket.layer.borderWidth = 2
        itemsInBasket.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        itemsInBasket.layer.cornerRadius = itemsInBasket.frame.size.height/2
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func updateCartInfo(userCart: UserCart){
        let servicesQuantity = calculateServicesNumber(userCart: userCart)
        let subTotal = calculateItemsServicesSubTotal(userCart: userCart)
        self.totalOrderPrice.text = "\(subTotal) ريال"
        self.itemsInBasket.text = "\(servicesQuantity)"
        
    }
    
    func setupItemData(){
        self.itemName.text = item!.name
        let imgUrl = NSURL(string: "\(item!.img)")! as URL
        itemImage.sd_setImage(with: imgUrl, completed: nil)
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func showBasketBtnPressed(_ sender: Any) {
        self.pushToCartVC(userCart: self.userCart!)
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
            let subTotal = calculateItemsServicesSubTotal(userCart: userCart)
            order.setSubTotal(subTotal: subTotal)
            shoppingBasketView.order = order
            shoppingBasketView.minimumPrice = self.minimumPrice
            shoppingBasketView.userCart = userCart
            shoppingBasketView.ordersCellHeight = cellHeight
            shoppingBasketView.delegate = self
            self.navigationController?.pushViewController(shoppingBasketView, animated: true)
        } else {
            let shoppingBasketView : shoppingBasketVC = self.storyboard?.instantiateViewController(withIdentifier: "SBVC") as! shoppingBasketVC
            let cellHeight = calculateItemsServicesNumber(userCart: userCart)
            let subTotal = calculateItemsServicesSubTotal(userCart: userCart)
            order.setSubTotal(subTotal: subTotal)
            shoppingBasketView.order = order
            shoppingBasketView.minimumPrice = self.minimumPrice
            shoppingBasketView.userCart = userCart
            shoppingBasketView.ordersCellHeight = cellHeight
            shoppingBasketView.delegate = self
            self.navigationController?.pushViewController(shoppingBasketView, animated: true)
        }
    }
    
    func calculateItemsServicesSubTotal(userCart: UserCart) -> Int {
        let itemsCount : Int = userCart.items.count
        var subTotal: Int = 0
        for i in 0..<itemsCount{
            let servicesCount : Int = userCart.items[i].services.count
            for j in 0..<servicesCount {
                let servicePrice = userCart.items[i].services[j].price
                var serviceQuantity = userCart.items[i].services[j].quantity
                if serviceQuantity == nil {
                    serviceQuantity = 0
                }
                if let itemSize = userCart.items[i].services[j].width{
                    subTotal = subTotal + (servicePrice * serviceQuantity! * itemSize)
                }else{
                    subTotal = subTotal + (servicePrice * serviceQuantity!)
                }
            }
        }
        return subTotal
    }
    
    func calculateServicesNumber(userCart: UserCart) -> Int {
        let itemsCount : Int = userCart.items.count
        var serviceQuantity : Int = 0
        for i in 0..<itemsCount{
            let servicesCount : Int = userCart.items[i].services.count
            for j in 0..<servicesCount {
                var quantity = userCart.items[i].services[j].quantity
                if quantity == nil {
                    quantity = 0
                }
                serviceQuantity = serviceQuantity + quantity!
            }
        }
        return serviceQuantity
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
            itemSizeCell.quantityDelegate = self
            itemSizeCell.viewDelegate = self
            itemSizeCell.updateCell(item: item!, serviceIndex: indexPath.row, userCartID: userCartID!)
            return itemSizeCell
        }else{
            let serviceOrderCell : serviceOrderCell = tableView.dequeueReusableCell(withIdentifier: "SOC") as! serviceOrderCell
            serviceOrderCell.delegate = self
            serviceOrderCell.viewDelegate = self
            serviceOrderCell.updateCell(item: item!, serviceIndex: indexPath.row, userCartID: userCartID!)
            return serviceOrderCell
        }
    }
}

extension orderItemVC: orderQuantity{
    
    func increaseQuantity(userCart: UserCart) {
        self.userCart = userCart
        updateCartInfo(userCart: userCart)
    }
    
    func decreaseQuantity(userCart: UserCart) {
        self.userCart = userCart
        updateCartInfo(userCart: userCart)
    }
    
}

extension orderItemVC: updateCart{
    func updateCart() {
        NetworkService.shared.requestUserCartData { (response) in
            self.userCart = response.data
            let subTotal = self.calculateItemsServicesSubTotal(userCart: response.data)
            let servicesQuantity = self.calculateServicesNumber(userCart: response.data)
            self.itemsInBasket.text = "\(servicesQuantity)"
            self.totalOrderPrice.text = "\(subTotal) ريال"
            self.orderServicesTV.reloadData()
        } onError: { (error) in
            debugPrint(error)
        }
    }
}

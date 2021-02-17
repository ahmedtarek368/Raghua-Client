//
//  orderPerSizeVC.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/12/21.
//

import UIKit

@available(iOS 13.0, *)
class orderPerSizeVC: UIViewController {

    @IBOutlet weak var exitBtn: basicShadowedBtn!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var bottomPopupView: bottomPopupView!
    @IBOutlet weak var showBasketBtn: basicShadowedBtn!
    @IBOutlet weak var itemsInBasket: UILabel!
    @IBOutlet weak var washIronQuantity: UILabel!
    @IBOutlet weak var sizeInMeters: UILabel!
    
    override func viewDidLayoutSubviews() {
        bottomPopupView.setBottomPopupHeight(height: Float(UIScreen.main.bounds.size.height/1.4))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupLayout(){
        exitBtn.isWhiteCircleButton()
        itemsInBasket.layer.borderWidth = 2
        itemsInBasket.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        itemsInBasket.layer.cornerRadius = itemsInBasket.frame.size.height/2
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func showBasketBtnPressed(_ sender: Any) {
        let shoppingBasketView : shoppingBasketVC = self.storyboard?.instantiateViewController(identifier: "SBVC") as! shoppingBasketVC
        self.navigationController?.pushViewController(shoppingBasketView, animated: true)
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addWashIronItemBtnPressed(_ sender: Any) {
        let quantity : Int = Int(washIronQuantity.text!)!
        washIronQuantity.text = "\(quantity+1)"
        let basketQuantity : Int = Int(itemsInBasket.text!)!
        itemsInBasket.text = "\(basketQuantity+1)"
    }
    
    @IBAction func removeWashIronItemBtnPressed(_ sender: Any) {
        let quantity : Int = Int(washIronQuantity.text!)!
        if quantity != 0 {
            washIronQuantity.text = "\(quantity-1)"
            let basketQuantity : Int = Int(itemsInBasket.text!)!
            itemsInBasket.text = "\(basketQuantity-1)"
        }
    }
    
    @IBAction func increaseItemSizeBtnPressed(_ sender: Any) {
        let size : Int = Int(sizeInMeters.text!)!
        sizeInMeters.text = "\(size+1)"
    }
    
    @IBAction func decreaseItemSizeBtnPressed(_ sender: Any) {
        let size : Int = Int(sizeInMeters.text!)!
        if size != 0 {
            sizeInMeters.text = "\(size-1)"
        }
    }
    
}

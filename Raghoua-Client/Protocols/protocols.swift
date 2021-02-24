//
//  protocols.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 1/30/21.
//

import Foundation

protocol dismissPopup {
    func didDismissPopup()
}

protocol sortLaundries {
    func sortLaundries(sortBy: Int)
}

protocol orderQuantity {
    func increaseQuantity(userCart: UserCart)
    func decreaseQuantity(userCart: UserCart)
}

protocol orderSize {
    func increaseSize(userCart: UserCart)
    func decreaseSize(userCart: UserCart)
}

protocol updateUserCart {
    func removeAndReloadTable(userCart: UserCart)
    func updateUserCart(userCart: UserCart)
}

protocol updateCartView{
    func updateCellHeight(userCart: UserCart)
    func updateCart(userCart: UserCart)
}

protocol pushToDeniedOrderDetails {
    func pushToDeniedOrderDetails()
}

protocol pushToCreditPaymentDetails {
    func pushToCreditPaymentDetails()
}

protocol pushToCompleteOrderDetails {
    func pushToCompleteOrderDetails()
}

protocol pushToWaitingCashPaymentOrderDetails {
    func pushToWaitingCashPaymentOrderDetails(order: OrderData)
}

protocol reloadData {
    func reloadData()
}

protocol confirmedVoucher{
    func confirmedVoucher(discountAmount: Int)
    
    func deniedVoucher()
}

protocol confirmDeliverRecieveDateTime{
    func confirmDeliverDate(date: String)
    func confirmDeliverTime(time: String)
    func confirmRecieveDate(date: String)
    func confirmRecieveTime(time: String)
}

protocol updateCart {
    func updateCart()
}

protocol updateFavorites{
    func updateFavorites()
}

protocol updateUserInfo {
    func updateUserInfo(user: User)
}

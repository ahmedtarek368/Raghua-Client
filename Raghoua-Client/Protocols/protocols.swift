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

protocol orderQuantity {
    func increaseQuantity(serviceIndex: Int)
    func decreaseQuantity(serviceIndex: Int)
}

protocol orderSize {
    func increaseSize()
    func decreaseSize()
}

protocol removeItem {
    func removeAndReloadTable()
}

protocol updateCellHeight{
    func updateCellHeight(userCart: UserCart)
}

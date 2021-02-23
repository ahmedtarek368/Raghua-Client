//
//  Order.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/22/21.
//

import Foundation


class Order{
    private(set) public var cartId: Int?
    private(set) public var addressId, subTotal, voucherDiscount: Int?
    private(set) public var total, deliveryFees: Int?
    private(set) public var deliveryDate, receiveDate, deliveryTime, receiveTime: String?
    private(set) public var paymentMethod, minimum: String?
    
    init(){}
    
    func setVoucherDiscount(voucherDiscount: Int){
        self.voucherDiscount = voucherDiscount
    }
    func setCartId(cartId: Int){
        self.cartId = cartId
    }
    func setAddressesId(addressId: Int){
        self.addressId = addressId
    }
    func setSubTotal(subTotal: Int){
        self.subTotal = subTotal
    }
    func setDeliveryFees(deliveryFees: Int){
        self.deliveryFees = deliveryFees
    }
    func setTotal(total: Int){
        self.total = total
    }
    func setDeliveryDate(deliveryDate: String){
        self.deliveryDate = deliveryDate
    }
    func setReceiveDate(receiveDate: String){
        self.receiveDate = receiveDate
    }
    func setDeliveryTime(deliveryTime: String){
        self.deliveryTime = deliveryTime
    }
    func setReceiveTime(receiveTime: String){
        self.receiveTime = receiveTime
    }
    func setPaymentMethod(paymentMethod: String){
        self.paymentMethod = paymentMethod
    }
    func setMinimum(minimum: String){
        self.minimum = minimum
    }
}

struct successfulVoucherResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let data: VoucherData
}

// MARK: - DataClass
struct VoucherData: Codable {
    let id: Int
    let code, promoValue, maxValue, validFrom: String
    let validTo: String

    enum CodingKeys: String, CodingKey {
        case id, code, promoValue, maxValue
        case validFrom = "valid_from"
        case validTo = "valid_to"
    }
}

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

struct successfulOrdersDataResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let data: [OrderData]
}

// MARK: - Datum
struct OrderData: Codable {
    let id: Int
    let orderNumber: String
    let createdAt: Int
    let laundryName: String
    let deliveryPrice: DeliveryPrice
    let serviceNumber: Int
    let total: String
    let status, paymentMethod: Int

    enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "order_number"
        case createdAt = "created_at"
        case laundryName
        case deliveryPrice = "delivery_price"
        case serviceNumber = "service_number"
        case total, status
        case paymentMethod = "payment_method"
    }
}

struct successfulOrderDetailsResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let data: OrderDetails
}

// MARK: - DataClass
struct OrderDetails: Codable {
    let id: Int
    let orderNumber: String
    let createdAt: Int
    let laundryName, deliveryPrice: String
    let serviceNumber: Int
    let total: String
    let status: Int
    let comment: String
    let paymentMethod: Int
    let receivedDate, receivedTime, deliveryDate, deliveryTime: String
    let address: addressesData
    let items: [RecieptItem]

    enum CodingKeys: String, CodingKey {
        case id
        case orderNumber = "order_number"
        case createdAt = "created_at"
        case laundryName
        case deliveryPrice = "delivery_price"
        case serviceNumber = "service_number"
        case total, status, comment
        case paymentMethod = "payment_method"
        case receivedDate = "received_date"
        case receivedTime = "received_time"
        case deliveryDate = "delivery_date"
        case deliveryTime = "delivery_time"
        case address, items
    }
}

struct RecieptItem: Codable {
    let id: Int
    let name: String
    let priceMethod: Int
    let services: [Service]

    enum CodingKeys: String, CodingKey {
        case id, name
        case priceMethod = "price_method"
        case services
    }
}

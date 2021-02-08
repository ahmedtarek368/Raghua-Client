//
//  Address.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/4/21.
//

import Foundation

class Address{
    let latitude: String
    let longitude: String
    let address: String
    let street: String
    let realStateNumber: Int
    let floorNumber: Int
    let apartmentNumber: Int
    let nearestPlace: String
    let addressType: Int
    
    init(latitude: String, longitude: String, address: String, street: String, realStateNumber: Int, floorNumber: Int, apartmentNumber: Int, nearestPlace: String, addressType: Int){
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.street = street
        self.realStateNumber = realStateNumber
        self.floorNumber = floorNumber
        self.apartmentNumber = apartmentNumber
        self.nearestPlace = nearestPlace
        self.addressType = addressType
    }
}

struct addressResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let data: [addressesData]
}

// MARK: - Datum
struct addressesData: Codable {
    let id, userID: Int
    let lat, long, address, street: String
    let realstateNumber, floorNumber, departNumber: Int
    let nearstPlace: String
    let addressType: Int

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case lat, long, address, street
        case realstateNumber = "realstate_number"
        case floorNumber = "floor_number"
        case departNumber = "depart_number"
        case nearstPlace = "nearst_place"
        case addressType = "address_type"
    }
}

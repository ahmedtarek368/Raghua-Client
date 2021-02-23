//
//  Laundry.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/14/21.
//

import Foundation

struct successfulGetLaundriesResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let dataa: Dataa
}

// MARK: - Dataa
struct Dataa: Codable {
    let currentPage: Int
    let data: [Laundry]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let links: [Link]
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Laundry
struct Laundry: Codable {
    let id: Int
    let name, minimumPrice: String
    let totalRate: Int
    let img: String
    let commnetCount: Int
    let distance: Double
    let deliveryTime: String
    let deliveryPrice: DeliveryPrice

    enum CodingKeys: String, CodingKey {
        case id, name, minimumPrice, totalRate, img, commnetCount, distance
        case deliveryTime = "delivery_time"
        case deliveryPrice
    }
}

enum DeliveryPrice: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(DeliveryPrice.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for DeliveryPrice"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: Label
    let active: Bool
}

enum Label: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Label.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Label"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

struct successfulGetLaundryResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let data: laundryDetails
}

// MARK: - DataClass
struct laundryDetails: Codable {
    let id: Int
    let name, minimumPrice, delivery: String
    let img: String
    let totalRate, fav, commnetCount: Int
    let catgories: [Catgory]
    let catgoriesItems: [CatgoriesItem]
    let about: About

    enum CodingKeys: String, CodingKey {
        case id, name
        case minimumPrice = "minimum_price"
        case delivery, img, totalRate, fav, commnetCount
        case catgories = "Catgories"
        case catgoriesItems = "CatgoriesItems"
        case about
    }
}

// MARK: - About
struct About: Codable {
    let deliveryIn, about, lat, long: String
    let workDays: [WorkDay]

    enum CodingKeys: String, CodingKey {
        case deliveryIn = "delivery_in"
        case about, lat, long, workDays
    }
}

// MARK: - WorkDay
struct WorkDay: Codable {
    let dayName, from, to: String

    enum CodingKeys: String, CodingKey {
        case dayName = "day_name"
        case from, to
    }
}

// MARK: - Catgory
struct Catgory: Codable {
    let id: Int
    let name: String
    let priceMethod: Int
    let price: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case priceMethod = "price_method"
        case price
    }
}

// MARK: - CatgoriesItem
struct CatgoriesItem: Codable {
    let catID: Int
    let catName: String
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case catID = "cat_id"
        case catName = "cat_name"
        case items = "Items"
    }
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let name: String
    let priceMethod: Int
    let img: String
    let services: [Catgory]

    enum CodingKeys: String, CodingKey {
        case id, name
        case priceMethod = "price_method"
        case img, services
    }
}

struct successfulGetReviewsResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let data: ReviewsData
}

// MARK: - DataClass
struct ReviewsData: Codable {
    let totalRate, commnetCount, dataWeak, lessMedium: Int
    let medium, good, excelent: Int
    let allReviews: [AllReview]

    enum CodingKeys: String, CodingKey {
        case totalRate, commnetCount
        case dataWeak = "weak"
        case lessMedium = "less_medium"
        case medium, good, excelent
        case allReviews = "all_reviews"
    }
}

// MARK: - AllReview
struct AllReview: Codable {
    let id: Int
    let userName: String
    let userImg: String
    let comment: String

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "user_name"
        case userImg = "user_img"
        case comment
    }
}

struct successfulUserCartResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let data: UserCart
}

// MARK: - DataClass
struct UserCart: Codable {
    let cartID, userID: Int
    let items: [UserItem]

    enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
        case userID = "user_id"
        case items
    }
}

// MARK: - Item
struct UserItem: Codable {
    let id: Int
    let name: String
    let laumdryID, priceMethod: Int
    let services: [Service]

    enum CodingKeys: String, CodingKey {
        case id, name
        case laumdryID = "laumdry_id"
        case priceMethod = "price_method"
        case services
    }
}

// MARK: - Service
struct Service: Codable {
    let id: Int
    let name: String
    let price, priceMethod: Int
    let quantity, width: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, quantity, price, width
        case priceMethod = "price_method"
    }
}

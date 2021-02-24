//
//  Urls.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/2/21.
//

import Foundation

class URLs{
    
    static let baseUrl = "https://raghuaapps.com/api/"
    
    static let login = baseUrl + "login"
    static let signup = baseUrl + "signup"
    static let getCode = baseUrl + "getCode"
    static let address = baseUrl + "addAddress"
    static let getAddress = baseUrl + "userAddress"
    static let socialLogin = baseUrl + "socail"
    static let resetPassword = baseUrl + "restpassword"
    static let getLaundries = baseUrl + "laundries"
    static let laundryDetails = baseUrl + "singleLaundary"
    static let laundryReviews = baseUrl + "laundaryRatereview"
    static let addToCart = baseUrl + "addtocart"
    static let getCart = baseUrl + "cartindex"
    static let removeItem = baseUrl + "deletefromcart"
    static let verifyVoucher = baseUrl + "checkcopouns"
    static let saveOrder = baseUrl + "saveOrder"
    static let updateCart = baseUrl + "updatecart"
    static let favorite = baseUrl + "addremovefav"
    static let favoriteLaundries = baseUrl + "myFav"
    static let myProfile = baseUrl + "myprofile"
    static let updateInfo = baseUrl + "updateUserInfo"
    
}


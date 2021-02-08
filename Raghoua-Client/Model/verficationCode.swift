//
//  verficationCode.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/3/21.
//

import Foundation


struct successVerficationCodeResponse: Codable {
    let status: Bool
    let errNum, msg: String
    let code: Int
}
struct failVerficationCodeResponse: Codable {
    let status: Bool
    let errNum, msg: String
}



//
//  networkServices.swift
//  Raghoua-Client
//
//  Created by Ahmed Tarek on 2/2/21.
//

import Foundation
import Alamofire

class NetworkService{
    static let shared = NetworkService()
    
    //MARK:- requestUserLogin
    func requestUserLogin(param: LoginParam, onSuccess: @escaping (successLoginSignupResponse) -> Void, onError: @escaping (String) -> Void){
        
        let url = URL(string: URLs.login)!
        let header = HTTPHeaders(["lang":"lang".localized])
        let params:[String:String] = [
            "user_info":param.user_info,
            "password":param.password
        ]
        
        AF.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            do{
                switch response.result{
                case .success(_):
                    let status = try JSONDecoder().decode(responseStatus.self, from: response.data!)
                    if status.status == true {
                        let successResponse = try JSONDecoder().decode(successLoginSignupResponse.self, from: response.data!)
                        onSuccess(successResponse)
                    }else{
                        let failedResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                        onError(failedResponse.msg)
                    }
                    break
                case .failure(let error):
                    onError(error.localizedDescription)
                    break
                }
            }catch(let err){
                onError(err.localizedDescription)
            }
        }
    }
    //MARK:- requestVerficationCode
    func requestVerficationCode(param: [String:String], onSuccess: @escaping (successVerficationCodeResponse) -> Void, onError: @escaping (String) -> Void){
        let url = URL(string: URLs.getCode)!
        let header = HTTPHeaders(["lang":"lang".localized])
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            do{
                switch response.result{
                case .success(_):
                    let status = try JSONDecoder().decode(responseStatus.self, from: response.data!)
                    if status.status == true {
                        let successResponse = try JSONDecoder().decode(successVerficationCodeResponse.self, from: response.data!)
                        onSuccess(successResponse)
                    }else{
                        let failedResponse = try JSONDecoder().decode(failVerficationCodeResponse.self, from: response.data!)
                        onError(failedResponse.msg)
                    }
                    break
                case .failure(let error):
                    onError(error.localizedDescription)
                    break
                }
            }catch(let err){
                onError(err.localizedDescription)
            }
        }
    }
    
    //MARK:- requestUserSignup
    func requestUserSignup(param:[String:String], image:UIImage, onSuccess: @escaping (successLoginSignupResponse) -> Void, onError: @escaping (String) -> Void){
            
            let url = URL(string: URLs.signup)!
            let header = HTTPHeaders(["lang":"lang".localized])
            AF.upload(multipartFormData: { (multipartFormData) in
                
                if let imageData = image.jpegData(compressionQuality: 0.2) {
                    multipartFormData.append(imageData, withName: "img",fileName: "image", mimeType: "image/jpg")
                }
                
                for (key, value) in param {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }, to: url , method: .post, headers: header).responseJSON { (response) in
                do{
                    switch response.result {
                    case .success(_):
                        let status = try JSONDecoder().decode(responseStatus.self, from: response.data!)
                        if status.status == true {
                            let successResponse = try JSONDecoder().decode(successLoginSignupResponse.self, from: response.data!)
                            onSuccess(successResponse)
                        }else{
                            let failedResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                            onError(failedResponse.msg)
                        }
                        break
                    case .failure(let error):
                        onError(error.localizedDescription)
                        break
                    }
                }catch(let err){
                onError(err.localizedDescription)
                    
                }
            }
        }
    
    //MARK:- requestAddUserAddress
    func requestAddUserAddress(param: [String:String], onSuccess: @escaping (basicResponse) -> Void, onError: @escaping (basicResponse) -> Void){
        let url = URL(string: URLs.address)!
        print(userToken!)
        let header = HTTPHeaders(["Authorization":"Bearer \(userToken!)", "lang":"lang".localized])
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            do{
                switch response.result{
                case .success(_):
                    let status = try JSONDecoder().decode(responseStatus.self, from: response.data!)
                    if status.status == true {
                        let successResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                        onSuccess(successResponse)
                    }else{
                        let failedResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                        onError(failedResponse)
                    }
                    break
                case .failure(_):
                    let failedResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                    onError(failedResponse)
                    break
                }
            }catch(let err){
                debugPrint(err.localizedDescription)
            }
        }
    }
    
    func requestGetUserAddresses(onSuccess: @escaping (addressResponse) -> Void, onError: @escaping (String) -> Void){
        let url = URL(string: URLs.getAddress)!
        print(userToken!)
        //let header = HTTPHeaders(["lang":"lang".localized])
        let header = HTTPHeaders(["Authorization":"Bearer \(userToken!)", "lang":"lang".localized])
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            do{
                switch response.result{
                case .success(_):
                    let status = try JSONDecoder().decode(responseStatus.self, from: response.data!)
                    if status.status == true {
                        let successResponse = try JSONDecoder().decode(addressResponse.self, from: response.data!)
                        onSuccess(successResponse)
                    }else{
                        let failedResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                        onError(failedResponse.msg)
                    }
                    break
                case .failure(let error):
                    onError(error.localizedDescription)
                    break
                }
            }catch(let err){
                debugPrint(err.localizedDescription)
            }
        }
    }
    
    func saveUserSocialData(param: [String:String], onSuccess: @escaping (successLoginSignupResponse) -> Void, onError: @escaping (String) -> Void){

        let url = URL(string: URLs.socialLogin)!
        let header = HTTPHeaders(["lang":"lang".localized])
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            do{
                switch response.result{
                case .success(_):
                    let status = try JSONDecoder().decode(responseStatus.self, from: response.data!)
                    if status.status == true {
                        let successResponse = try JSONDecoder().decode(successLoginSignupResponse.self, from: response.data!)
                        onSuccess(successResponse)
                    }else{
                        let failedResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                        onError(failedResponse.msg)
                    }
                    break
                case .failure(let error):
                    onError(error.localizedDescription)
                    break
                }
            }catch(let err){
                onError(err.localizedDescription)
            }
        }
        
    }
    
    func requestResetPassword(param: [String:String], onSuccess: @escaping (basicResponse) -> Void, onError: @escaping (basicResponse) -> Void){
        
        let url = URL(string: URLs.resetPassword)!
        let header = HTTPHeaders(["lang":"lang".localized])
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil).responseJSON { (response) in
            do{
                switch response.result{
                case .success(_):
                    let status = try JSONDecoder().decode(responseStatus.self, from: response.data!)
                    if status.status == true {
                        let successResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                        onSuccess(successResponse)
                    }else{
                        let failedResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                        onError(failedResponse)
                    }
                    break
                case .failure(_):
                    let failedResponse = try JSONDecoder().decode(basicResponse.self, from: response.data!)
                    onError(failedResponse)
                    break
                }
            }catch(let err){
                debugPrint(err.localizedDescription)
            }
        }
    }
    
}


//let headers = HTTPHeaders(["Authorization" : "\(userToken)"])

//let session = URLSession(configuration: .default)
//
//func userLoging(loginParam: LoginParam, onSuccess: @escaping (userResponse) -> Void, onError: @escaping (String) -> Void){
//
//    let url = URL(string: URLs.login)!
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.addValue("application/json", forHTTPHeaderField: "Accept")
//    request.headers = HTTPHeaders(["lang":"ar"])
//    do{
//        let body = try JSONEncoder().encode(loginParam)
//        request.httpBody = body
//        let task = session.dataTask(with: request) { (data, response, error) in
//
//            DispatchQueue.main.async {
//                if let error = error {
//                    onError(error.localizedDescription)
//                    return
//                }
//                guard let data = data, let response = response as? HTTPURLResponse else {
//                    onError("Invalid data or response")
//                    return
//                }
//
//                do {
//                    if response.statusCode == 200 {
//                        let user = try JSONDecoder().decode(userResponse.self, from: data)
//                        onSuccess(user)
//                    } else {
//                        //let err = try JSONDecoder().decode(APIError.self, from: data)
//                        onError("error")
//                    }
//                } catch {
//                    onError(error.localizedDescription)
//                }
//            }
//        }
//        task.resume()
//    }catch(let err){
//    onError(err.localizedDescription)
//    }
//}

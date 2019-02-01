//
//  AuthService.swift
//  smack
//
//  Created by Graphene on 28/1/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    static let instance = AuthService()
    private init() {}
    
    let defaults = UserDefaults.standard
    var isLoggedIn : Bool{
        get{
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue,forKey: LOGGED_IN_KEY)
            
        }
    }
    
    var authToken: String{
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String{
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL)
        }
        
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandle){
        let lowerCaseEmail = email.lowercased()
        
        let body : [String: Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            if response.result.error == nil{
                completion(true)
            } else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func loginUser(email: String, password: String, completion: @escaping CompletionHandle){
        let lowerCaseEmail = email.lowercased()
        
        let body : [String: Any] = [
            "email" : lowerCaseEmail,
            "password" : password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            //Old
            if response.result.error == nil{
                //Swifty JSON
                guard let data = response.data else {return}
                do{
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    self.isLoggedIn = true
                    completion(true)
                }catch{
                    debugPrint("Failed to get JSON response ")
                }
                
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandle){
        let lowerCaseEmail = email.lowercased()
        let body :[String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        

        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
                do {
                    try self.setUserData(data: data)
                    completion(true)
                }catch{
                    completion(false)
                    debugPrint("Cannot convert response to SwiftyJSON")
                    
                }
                
            } else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandle){
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                guard let data = response.data else {return}
                do {
                    try self.setUserData(data: data)
                    completion(true)
                }catch{
                    completion(false)
                    debugPrint("Cannot convert response to SwiftyJSON")
                    
                }
                
            } else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    func setUserData(data: Data) throws {
        let json =  try JSON(data: data)
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let email = json["email"].stringValue
        let avatarName = json["avatarName"].stringValue
        let avatarColor = json["avatarColor"].stringValue
        UserDataService.instance.setUserData(id: id, avatarColor: avatarColor, avatarName: avatarName, email: email, name: name)
    }
}

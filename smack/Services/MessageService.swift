//
//  MessageService.swift
//  smack
//
//  Created by Graphene on 1/2/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance =  MessageService()
    private init(){}
    
    var channels = [Channel]()
    
    func findAllChannel(completion: @escaping CompletionHandle){
        Alamofire.request(URL_GET_CHANNELS, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
            
                do{
                    if let json = try JSON(data: data).array {
                        for item in json {
                            let name = item["name"].stringValue
                            let description = item["description"].stringValue
                            let id = item["_id"].stringValue
                            
                            let channel = Channel(channelTitle: name, channelDescription: description, id: id)
                            self.channels.append(channel)
                            print(self.channels[0].channelTitle)
                        }
                    }
                }catch{
                    debugPrint("Cannot get all channels! Casting JSON failed")
                }
                completion(true)
            } else {
                completion(false)
                debugPrint("Cannot get all channels!")
//                debugPrint(response.result.error as Any)
            }
        }
    }
}

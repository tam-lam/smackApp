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
    var messages = [Message]()
    var selectedChannel: Channel?
    
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
                            NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
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
    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandle ){
        Alamofire.request("\(URL_GET_MESSAGES)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            if response.result.error == nil{
                self.clearMessages()
                guard let data = response.data else {return}
                do {
                    if let json = try JSON(data: data).array{
                        for item in json{
                            let messageBody = item["messageBody"].stringValue
                            let channelId = item["channelId"].stringValue
                            let id = item["_id"].stringValue
                            let userName = item["userName"].stringValue
                            let userAvatar = item["userAvatar"].stringValue
                            let userAvatarColor = item["userAvatarColor"].stringValue
                            let timeStamp = item["timeStamp"].stringValue
                            
                            let message = Message(message: messageBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                            self.messages.append(message)
                        }
                        print(self.messages)
                        completion(true)
                    }
                }catch let error {
                    debugPrint(error as Any)
                }
                
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    func clearMessages(){
        messages.removeAll()
    }
    func clearChannels(){
        channels.removeAll()
    }
}

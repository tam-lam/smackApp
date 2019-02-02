//
//  SocketService.swift
//  smack
//
//  Created by Graphene on 1/2/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()
    private override init() {
        super.init()
    }
    
    let manager = SocketManager(socketURL: URL(string: "\(BASE_URL)")!)
    lazy var socket: SocketIOClient = manager.defaultSocket
//    var socket : SocketIOClient = SocketManager(socketURL: URL(string: "\(BASE_URL)")!).defaultSocket
    func establishConnection (){
        socket.connect()
    }
    
    func closeConnection (){
        socket.disconnect()
    }
    func addChannel(channelName: String, channelDescription: String,completion: @escaping CompletionHandle){
        socket.emit("newChannel", channelName, channelDescription)
        print("New channel is created: \(channelName)")
        completion(true)
    }
    func getChannel(completion: @escaping CompletionHandle){
        print("getting channel")
        socket.on("channelCreated") { (dataArray, ack) in
            print("ACK: channelCreated")
            print("dataArray: \(dataArray)")
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}

            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId:String, channelId: String, completion: @escaping CompletionHandle){
        let user = UserDataService.instance
        socket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    func getChatMessage(completion: @escaping CompletionHandle){
        socket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            if channelId == MessageService.instance.selectedChannel?.id && AuthService.instance.isLoggedIn{
                
                let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                MessageService.instance.messages.append(newMessage)
                completion(true)
            }else {
                completion(false)
            }

        }
    }
}


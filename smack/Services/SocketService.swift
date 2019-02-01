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
    override init() {
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
}

//
//  Channel.swift
//  smack
//
//  Created by Graphene on 1/2/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import Foundation
struct Channel: Decodable {
    
    public private(set) var _id: String!
    public private(set) var name: String!
    public private(set) var description: String!
    public private(set) var __v: Int!
    
    public init(name: String, description: String, id: String){
        self._id = id
        self.name = name
        self.description = description
    }
    
    public var channelTitle: String! {
        get{
            return self.name
        }
    }
    public var channelDescription:String! {
        get{
            return self.description
        }
    }
    public var id:String! {
        get{
            return self._id
        }
    }
}

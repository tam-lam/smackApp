//
//  Channel.swift
//  smack
//
//  Created by Graphene on 1/2/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import Foundation
struct Channel {
    
    public private(set) var channelTitle: String!
    public private(set) var channelDescription: String!
    public private(set) var id: String!
    
    public init(channelTitle: String, channelDescription: String, id: String){
        self.channelTitle = channelTitle
        self.channelDescription = channelDescription
        self.id = id
    }
}

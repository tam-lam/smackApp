//
//  UserDataService.swift
//  smack
//
//  Created by Graphene on 30/1/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import Foundation

class UserDataService{
    static let instance = UserDataService()
    
    private(set) public var id = ""
    private(set) public var avatarColor = ""
    private(set) public var avatarName = ""
    private(set) public var email = ""
    private(set) public var name = ""

    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name : String){
        self.id = id
        self.avatarName = avatarName
        self.avatarColor = avatarColor
        self.name = name
        self.email = email
    }
    
    func setAvatarName(avatarName: String){
        self.avatarName = avatarName
    }
}

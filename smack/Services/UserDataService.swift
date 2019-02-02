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
    private init(){}
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
    
    func returnUIColor(components: String) ->UIColor {
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ]")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        var r,b,g,a : NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newColor
    }
    
    func logoutUser(){
        id = ""
        name = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        AuthService.instance.isLoggedIn = false
        AuthService.instance.authToken = ""
        AuthService.instance.userEmail = ""
        MessageService.instance.clearChannels()
        MessageService.instance.clearMessages()
    }
}

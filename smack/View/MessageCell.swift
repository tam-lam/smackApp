//
//  MessageCell.swift
//  smack
//
//  Created by Graphene on 2/2/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var timeStampLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(message: Message){
        userImg.image = UIImage(named: message.userAvatar)
        userNameLbl.text = message.userName
        messageBodyLbl.text = message.message
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }
}

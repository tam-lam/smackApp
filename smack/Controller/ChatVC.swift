//
//  ChatVC.swift
//  smack
//
//  Created by Graphene on 26/1/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var chatNameLbl: UILabel!
    @IBOutlet weak var menuBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChanged(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.channelSelected(_:)), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn{
            AuthService.instance.findUserByEmail { (success) in
                if success{
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            }
        }
        
    }
    @objc func channelSelected(_ notif: Notification){
        updateWithChannel()
    }
    func updateWithChannel(){
        let channelName = MessageService.instance.selectedChannel?.channelTitle ?? ""
        chatNameLbl.text = "#\(channelName)"
    }
    
    @objc func userDataDidChanged (_ notif: Notification){
        if AuthService.instance.isLoggedIn{
            onLoginGetMessage()
        }else{
            chatNameLbl.text = "Please log In"
        }
    }
    
    func onLoginGetMessage(){
        MessageService.instance.findAllChannel { (success) in
            if success{
                
            }
        }
    }
}

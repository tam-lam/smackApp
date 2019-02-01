//
//  ChannelVC.swift
//  smack
//
//  Created by Graphene on 26/1/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SocketService.instance.getChannel { (success) in
            if success{
                print("new channel is added...")
                self.tableView.reloadData()
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
        self.revealViewController()!.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChanged), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
        SocketService.instance.getChannel { (success) in
            if success{
                print("new channel is added...")
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func addChannelPressed(_ sender: Any) {
        let addChannelVC = AddChannelVC()
        addChannelVC.modalPresentationStyle = .custom
        present(addChannelVC, animated: true, completion: nil)
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        if AuthService.instance.isLoggedIn {
            let profile = ProfileVC()
            profile.modalPresentationStyle = .custom
        
            present(profile, animated: true, completion: nil)
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @objc func userDataDidChanged (_ notif: Notification){
        setUpUserInfo()
    }
    func setUpUserInfo(){
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle(UserDataService.instance.name, for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else{
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
}
extension ChannelVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelCell{
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configCell(channel: channel)
            return cell
        }
        return ChannelCell()
    }
    
    
}

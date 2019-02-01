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
    @IBOutlet weak var userImg: CircleImage!
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()!.rearViewRevealWidth = self.view.frame.width - 60
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChanged), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        setUpUserInfo()
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

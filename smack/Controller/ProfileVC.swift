//
//  ProfileVC.swift
//  smack
//
//  Created by Graphene on 31/1/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    //Outlets
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closedPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func logoutPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        userImg.image = UIImage(named: UserDataService.instance.avatarName)
        userName.text = UserDataService.instance.name
        userEmail.text = UserDataService.instance.email
        userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.tapToClose(_:)))
        bgView.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapToClose(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}

//
//  CreateAccountVC.swift
//  smack
//
//  Created by Graphene on 26/1/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else {return}
        guard let password = passwordTxt.text, passwordTxt.text != "" else {return}
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                debugPrint("Register user successfully")
                AuthService.instance.loginUser(email: email, password: password, completion: { (success) in
                    if success {
                        debugPrint("User is logged in. \(AuthService.instance.authToken)")
                    }
                })
            }
        }
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func pickBgColorPressed(_ sender: Any) {
    }
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_TO_CHANNEL, sender: nil)
    }
    


}

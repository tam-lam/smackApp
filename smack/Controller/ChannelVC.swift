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
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()!.rearViewRevealWidth = self.view.frame.width - 60
    }
    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    

}

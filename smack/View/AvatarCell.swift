//
//  AvatarCell.swift
//  smack
//
//  Created by Graphene on 30/1/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    func setupView(){
        self.layer.cornerRadius = 10
        self.layer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.clipsToBounds = true
    }
    
}

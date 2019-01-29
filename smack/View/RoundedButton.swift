//
//  RoundedButton.swift
//  smack
//
//  Created by Graphene on 29/1/19.
//  Copyright © 2019 Graphene. All rights reserved.
//

import UIKit
@IBDesignable
class RoundedButton: UIButton {
    @IBInspectable var cornerRadius : CGFloat = 5.0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    override func awakeFromNib() {
        self.setupView()
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }
}

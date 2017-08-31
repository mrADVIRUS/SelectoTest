//
//  CustomTextView.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 29.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor(red:0.22, green:0.71, blue:0.75, alpha:1.0).cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 2.0
    }

}

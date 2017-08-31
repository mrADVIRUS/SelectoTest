//
//  CustomRoundImage.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 30.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit

class CustomRoundImage: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}

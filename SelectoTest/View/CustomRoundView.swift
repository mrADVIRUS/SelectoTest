//
//  CustomRoundView.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 30.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit

class CustomRoundView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor(red:0.77, green:0.79, blue:0.79, alpha:1.0).cgColor
        layer.borderWidth = 1
        layer.cornerRadius = self.frame.width / 2
    }


}

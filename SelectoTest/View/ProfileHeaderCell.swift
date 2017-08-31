//
//  ProfileHeaderCell.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 30.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var ivLogo: CustomRoundImage!
    static let identifier = "profileHeaderCell"
    
    @IBAction func onBtnPressed(_ sender: Any) {
        print("Are you shure?")
    }
}

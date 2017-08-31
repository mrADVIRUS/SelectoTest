//
//  PostCell.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 30.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    @IBOutlet weak var vFeatured: UIView!
    @IBOutlet weak var lblTitlePost: UILabel!
    
    static let identifier = "postCell"
    
    func configureCell(futurePost: Bool) {
        vFeatured.isHidden = !futurePost
        
    }
}

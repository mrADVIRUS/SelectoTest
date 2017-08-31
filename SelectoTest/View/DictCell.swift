//
//  DictCell.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 30.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit

class DictCell: UITableViewCell {

    @IBOutlet weak var lblDirection: UILabel!
    
    @IBOutlet weak var tvFrom: CustomTextView!
    @IBOutlet weak var tvTo: CustomTextView!
    
    static let identifier = "dictCell"
    
    func configureCell(item: Translate) {
        lblDirection.text = item.direction
        tvFrom.text = item.from
        tvTo.text = item.to
    }
}

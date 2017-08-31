//
//  GifCell.swift
//  SelectoTest
//
//  Created by Sergiy Lyahovchuk on 30.08.17.
//  Copyright © 2017 HardCode. All rights reserved.
//

import UIKit
import FLAnimatedImage

class GifCell: UICollectionViewCell {
    
    @IBOutlet weak var ivGif: FLAnimatedImageView!
    static let identifier = "gifCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
    
    func configureCell(gifName: String) {
        let fileUrl = Bundle.main.url(forResource: gifName, withExtension: "gif")!

        do {
            let data = try Data(contentsOf: fileUrl)
            let animImage = FLAnimatedImage.init(animatedGIFData: data)
            self.ivGif.animatedImage = animImage
        } catch  {
            print("Error loading image : \(error)")
        }
    }
    /*
    func configureCell(gifName: String) {
        //gifImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%li", (long)indexPath.row] ofType:@"gif"]]];
        let strImage = Bundle.main.path(forResource: gifName, ofType: "gif")
        let fileUrl2 = Bundle.main.url(forResource: gifName, withExtension: "gif")!
//        let fileUrl2 = Bundle.main.url(forResource: "android", withExtension: "png")!
        print(strImage!)
        do {
            let data = try Data(contentsOf: fileUrl2)
            self.ivGif?.image = UIImage(data: data as Data)
        } catch  {
            print("Error loading image : \(error)")
        }
    }
 */
}

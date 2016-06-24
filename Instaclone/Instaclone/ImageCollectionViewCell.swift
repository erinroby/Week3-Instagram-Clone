//
//  ImageCollectionViewCell.swift
//  Instaclone
//
//  Created by Erin Roby on 6/22/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var post: Post? {
        didSet {
            self.imageView.image = self.post?.image
        }
    }
    
    class func id() -> String {
        return String(self)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    } // clearing out the imageView before we set another when we scroll
}

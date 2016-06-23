//
//  GalleryCustomFlowLayout.swift
//  Instaclone
//
//  Created by Erin Roby on 6/22/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class GalleryCustomFlowLayout: UICollectionViewFlowLayout {
    let columns: Int
    let space: CGFloat = 1.0
    init(columns: Int = 3) { // set a default if you don't pass in anything.
        self.columns = columns // initialize self first, then super.
         super.init()
         self.setup()
    }
    
    required init?(coder aDecorder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        self.minimumLineSpacing = self.space
        self.minimumInteritemSpacing = self.space
        self.itemSize = CGSize(width: self.itemWidth(), height: self.itemWidth())
    }
    
    func itemWidth() -> CGFloat {
        let width = UIScreen.mainScreen().bounds.width
        let availableWidth = width - (CGFloat(self.columns) * self.space)
        return availableWidth / CGFloat(self.columns)
    }
}

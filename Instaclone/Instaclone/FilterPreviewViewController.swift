//
//  FilterPreviewViewController.swift
//  Instaclone
//
//  Created by Erin Roby on 6/23/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class FilterPreviewViewController: UIViewController, Identity { // create this protocol so we can use it below...from Twitter App.

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: FilterPreviewViewControllerDelegate?
    
    let filters = [Filter.shared.original, Filter.shared.bw, Filter.shared.chrome, Filter.shared.vintage, Filter.shared.fade, Filter.shared.invert] // array of functions, which is why we had to write the extra function.
    
    var post = Post()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout(columns: 2)
    }

}

// I want my core class to be must-have, extensions are for additional things
extension FilterPreviewViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func configureCellForIndexPath(indexPath: NSIndexPath) -> ImageCollectionViewCell {
        let imageCell = self.collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
    
        self.filters[indexPath.row](post.image, completion: { imageCell.imageView.image = $0 }) // $0 is just a placeholder
        return imageCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.configureCellForIndexPath(indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let delegate = self.delegate else { return }
        let imageCell = collectionView.cellForItemAtIndexPath(indexPath) as! ImageCollectionViewCell
        
        if let image = imageCell.imageView.image {
                delegate.didPickImage(true, image: image)
        }  else {
            delegate.didPickImage(false, image: nil)
        }
        
    }
}





































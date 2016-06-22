//
//  GalleryViewController.swift
//  Instaclone
//
//  Created by Erin Roby on 6/22/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datasource = [Post]() {
        didSet {
            self.collectionView.reloadData()
        }
    }

    class func id() ->  String {
        return String(self) // self is GalleryViewController here
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        self.collectionView.dataSource = self // dataSource as a inherited property
        self.collectionView.collectionViewLayout = GalleryCustomFlowLayout()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpAppearance()
        self.update()
    }
    
    func update() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        API.shared.GET { (posts) in
            if let posts = posts {
                self.datasource = posts
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setUpAppearance() {
        self.title = "Gallery"
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.datasource.count // datasource is our array variable in scope
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.id(), forIndexPath: indexPath) as! ImageCollectionViewCell
        cell.post = self.datasource[indexPath.row]
        return cell
    }

    
}

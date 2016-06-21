//
//  ViewController.swift
//  Instaclone
//
//  Created by Erin Roby on 6/20/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, Setup {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        self.navigationItem.title = "Instaclone"
    }
    
    func setupAppearance() {
        self.imageView.layer.cornerRadius = 3.0
    }

    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "source", message: "please select the source type", preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "camera", style: .Default) { (action) in self.presentImagePicker(.Camera)
        }
        let photosAction = UIAlertAction(title: "photos", style: .Default) { (action) in self.presentImagePicker(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photosAction)
        actionSheet.addAction(cancelAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addButtonSelected(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
    @IBAction func editButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return } // if the image is blank, we don't want that to work with our button. Nothing to edit!
        
        let actionSheet = UIAlertController(title: "Filter", message: "Please select a Filter", preferredStyle: .ActionSheet)
        let vintageFilter = UIAlertAction(title: "Vintage", style: .Default) { (action) in Filter.vintage(image) { (theImage) in
            self.imageView.image = theImage }
            }
        let bwFilter = UIAlertAction(title: "Black & White", style: .Default) { (action) in Filter.bw(image) { (theImage) in
            self.imageView.image = theImage }
        }
        let chromeFilter = UIAlertAction(title: "Chrome", style: .Default) { (action) in Filter.chrome(image) { (theImage) in
            self.imageView.image = theImage }
        }
        let fadeFilter = UIAlertAction(title: "Fade", style: .Default) { (action) in Filter.fade(image) { (theImage) in
            self.imageView.image = theImage }
        }
        let invertFilter = UIAlertAction(title: "Invert", style: .Default) { (action) in Filter.invert(image) { (theImage) in
            self.imageView.image = theImage }
        }
        let resetAction = UIAlertAction(title: "Reset", style: .Default) { (action) in self.imageView.image = Filter.original }
        let cancelAction = UIAlertAction(title: "cancel", style: .Cancel, handler: nil)
        
        actionSheet.addAction(vintageFilter)
        actionSheet.addAction(bwFilter)
        actionSheet.addAction(chromeFilter)
        actionSheet.addAction(fadeFilter)
        actionSheet.addAction(invertFilter)
        actionSheet.addAction(resetAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your new image has been saved to your photos!", preferredStyle: .Alert)
            
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save Error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveButtonSelected(sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        
        API.shared.POST(Post(image: image)) { (success) in
            if success {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image), nil)
                print("YAY!!!")
            }
        }
    }
    
    func imagePickerControllerDidCanel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String: AnyObject]?) {
        self.imageView.image = image
        Filter.original = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}


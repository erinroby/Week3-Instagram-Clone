//
//  Filter.swift
//  Instaclone
//
//  Created by Erin Roby on 6/21/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

typealias FilterCompletion = (theImage: UIImage?) -> ()

class Filter {
    static var original = UIImage() // reference original in case user changes mind later!
    
    private class func filter(name: String, image: UIImage, completion: FilterCompletion) { // creating a context is extrememly expensive. refactor to make a singleton where the context is created just once. perhaps make this take an array of filter names with a for loop?
        NSOperationQueue().addOperationWithBlock {
            guard let filter = CIFilter(name: name) else { fatalError("Check yo spelling!") } // consider names enum for strings to avoid typo bugs.
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey) // creating conversion from UIImage to CIImage inline here.
            let options = [kCIContextWorkingColorSpace : NSNull()] // boilerplate code
            let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("No output image created.") }
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent) // explicitly using GPUContext. Default CPU otherwise.
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    class func vintage(image: UIImage, completion: FilterCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
    class func bw(image: UIImage, completion: FilterCompletion) {
       self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    class func chrome(image: UIImage, completion: FilterCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
    class func fade(image: UIImage, completion: FilterCompletion) {
        self.filter("CIPhotoEffectFade", image: image, completion: completion)
    }
    
    class func invert(image: UIImage, completion: FilterCompletion) {
        self.filter("CIColorInvert", image: image, completion: completion)
    }
}

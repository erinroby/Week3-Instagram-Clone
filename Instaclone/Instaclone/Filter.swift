//
//  Filter.swift
//  Instaclone
//
//  Created by Erin Roby on 6/21/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit
import CloudKit

typealias FilterCompletion = (theImage: UIImage?) -> ()

class Filter {
    static let shared = Filter()
    private let context: CIContext
    var original = UIImage()
    
    private init() {
        let options = [kCIContextWorkingColorSpace : NSNull()] // boilerplate code
        let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGContext, options: options)
    } // reference original in case user changes mind later!
    
    private func filter(name: String, image: UIImage, completion: FilterCompletion) {
        NSOperationQueue().addOperationWithBlock {
            
        guard let filter = CIFilter(name: name) else { fatalError("Check yo spelling!") } // consider names enum for strings to avoid typo bugs.
        filter.setValue(CIImage(image: image), forKey: kCIInputImageKey) // creating conversion from UIImage to CIImage inline here.
       
        guard let outputImage = filter.outputImage else { fatalError("No output image created.") }
        let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent) // explicitly using GPUContext. Default CPU otherwise.
        
        NSOperationQueue.mainQueue().addOperationWithBlock({
            completion(theImage: UIImage(CGImage: cgImage))
            })
        }
    }
    
    func original(image: UIImage, completion: FilterCompletion) {
        completion(theImage: self.original)
    }
    
     func vintage(image: UIImage, completion: FilterCompletion) {
        self.filter("CIPhotoEffectTransfer", image: image, completion: completion)
    }
    
     func bw(image: UIImage, completion: FilterCompletion) {
       self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
     func chrome(image: UIImage, completion: FilterCompletion) {
        self.filter("CIPhotoEffectChrome", image: image, completion: completion)
    }
    
     func fade(image: UIImage, completion: FilterCompletion) {
        self.filter("CIPhotoEffectFade", image: image, completion: completion)
    }
    
     func invert(image: UIImage, completion: FilterCompletion) {
        self.filter("CIColorInvert", image: image, completion: completion)
    }
}

//
//  ModelAdditions.swift
//  Instaclone
//
//  Created by Erin Roby on 6/21/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit
import CloudKit

enum PostError : ErrorType {
    case WritingImage
    case CreateCKRecord
}

extension Post {
    class func recordWith(post: Post) throws -> CKRecord? {
        let imageURL = NSURL.imageURL()
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.WritingImage }
        let saved = data.writeToURL(imageURL, atomically:  true) // this is a boolean. If writeToURL is sucessfull, saved is true.
        
        if saved {
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: "Post") // use class name as we have here.
            record.setObject(asset, forKey: "image") // CKRecord is a key-value pair and this where we set those values. 
            return record
        } else {
            throw PostError.CreateCKRecord
        }
    }
}



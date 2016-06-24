//
//  API.swift
//  Instaclone
//
//  Created by Erin Roby on 6/21/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//
import UIKit
import CloudKit

typealias APICompletion = (success: Bool) -> ()

class API {
    static let shared = API() // Singleton
    let container: CKContainer
    let database: CKDatabase
    
    private init() { // API is a singleton so it needs to be initialized only once.
        self.container = CKContainer.defaultContainer()
        self.database = self.container.privateCloudDatabase
    }
    
    func POST(post: Post, completion: APICompletion) {
        do {
            if let record = try Post.recordWith(post) {
                self.database.saveRecord(record, completionHandler: { (record, error) in
                    if error == nil && record != nil {
                        print(record)
                        completion(success: true)
                    }
                })
            }
        } catch let error { print(error) }
    }
    
    func GET(completion: (posts: [Post]?) -> ()) {
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true)) // give me all posts where there is a value.
            self.database.performQuery(query, inZoneWithID: nil) { (records, error) in
                if let error = error {
                    print(error)
                }
                if let records = records {
                    var posts = [Post]()
                    for record in records {
                        guard let asset = record["image"] as? CKAsset else { return }
                        guard let path = asset.fileURL.path else { return }
                        guard let image = UIImage(contentsOfFile: path) else { return }
                        posts.append(Post(image: image))
                    }
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock({
                        completion(posts: posts)
                    })
                }
                completion(posts: nil)
        }
    }
}

//
//  FilterPreviewControllerDelegate.swift
//  Instaclone
//
//  Created by Erin Roby on 6/23/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

protocol FilterPreviewViewControllerDelegate: class {
    func didPickImage(success: Bool, image: UIImage?) -> ()
}
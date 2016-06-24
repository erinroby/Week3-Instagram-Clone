//
//  Identity.swift
//  Instaclone
//
//  Created by Erin Roby on 6/23/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

import UIKit

protocol Identity {
    static func id() -> String
}

extension Identity {
    static func id() -> String {
        return String(self)
    }
}

//
//  Profile.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 19/2/18.
//  Copyright © 2018 Nicolas Melo. All rights reserved.
//

import Foundation
import RealmSwift

class Profile: Object {
    @objc dynamic var isExpandable = true
    @objc dynamic var isExpanded = false
    @objc dynamic var isVisible = true
    @objc dynamic var relatesTo = ""
    @objc dynamic var primaryTitle = ""
    @objc dynamic var secondaryTitle = ""
    @objc dynamic var cellIdentifier = ""
    @objc dynamic var additionalRows = 0
    @objc dynamic var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

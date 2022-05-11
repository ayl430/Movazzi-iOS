//
//  Bookmark.swift
//  Movazzi
//
//  Created by yeri on 2022/04/15.
//

import Foundation
import RealmSwift

class Bookmark: Object {
    
    @objc dynamic var movieId: Int = 0
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var date: Date?

    override static func primaryKey() -> String? {
        return "movieId"
    }
    
}

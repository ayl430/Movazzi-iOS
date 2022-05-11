//
//  Diary.swift
//  Movazzi
//
//  Created by yeri on 2022/04/15.
//

import Foundation
import RealmSwift

class Diary: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted dynamic var movieId: Int = 0
    @Persisted dynamic var posterPath: String = ""
    @Persisted dynamic var writeDate: Date?
    @Persisted dynamic var date: String = ""
    @Persisted dynamic var title: String = ""
    @Persisted dynamic var rate: Int = 0
    @Persisted dynamic var review: String = ""
    
}

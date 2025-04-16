//
//  recs.swift
//  C2
//
//  Created by POS on 4/8/25.
//
// challenge records(memos) structure
//

import Foundation
import SwiftData

@Model
class Recs {
    var category: String
    var title: String
    var content: String
    var level: Float
    var isDel: Bool = false // is deleted? (moved to trash?)

    init(category: String, title: String, content: String, level: Float = 5.0, isDel: Bool = false) {
        self.category = category
        self.title = title
        self.content = content
        self.level = level
        self.isDel = false
    }
}



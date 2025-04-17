//
//  dats.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import Foundation
import SwiftData

@Model
class Dats {
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

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
    var level: Double
    var isDel: Bool = false // is deleted? (moved to trash?)
    var date: Date

    init(category: String, title: String, content: String, level: Double = 0.17, isDel: Bool = false, date: Date = Date()) {
        self.category = category
        self.title = title
        self.content = content
        self.level = level
        self.isDel = false
        self.date = date
    }
}

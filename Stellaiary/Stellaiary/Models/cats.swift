//
//  cats.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import Foundation
import SwiftData

@Model
class Cats {  //categories

    var name: String
    var color: String

    init(name: String, color: String) {
        self.name = name
        self.color = color
    }

    static func sortCats(cats: [Cats]) -> [Cats] {
        return cats.sorted {
            $0.name == "기타" ? false : ($1.name == "기타" ? true : true)
        }
    }
    
    static func datFilter(for category: Cats, from dats: [Dats]) -> [Dats] {
        return dats.filter { $0.category == category.name }
    }
}

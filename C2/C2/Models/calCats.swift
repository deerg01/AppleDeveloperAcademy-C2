//
//  calCats.swift
//  C2
//
//  Created by POS on 4/8/25.
//
// challenge categories structure


enum Cats: String, CaseIterable, Identifiable, Hashable {
    case aa = "자기계발"
    case ab = "취미"
    case ac = "건강"
    case ad = "교류"
    case zz = "기타"

    var id: String { self.rawValue }
    var name: String { self.rawValue }
      
    init?(raw: String) {
        self.init(rawValue: raw)
    }
}

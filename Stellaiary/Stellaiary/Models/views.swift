//
//  views.swift
//  Stellaiary
//
//  Created by POS on 4/22/25.
//

import Foundation
import SwiftData

enum SelectedViewType {
    case none
    case write
    case edit(Dats)
    case list
    case trash
}

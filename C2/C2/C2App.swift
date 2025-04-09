//
//  C2App.swift
//  C2
//
//  Created by POS on 4/8/25.
//

import SwiftUI
import SwiftData

@main
struct C2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Recs.self)
    }
}

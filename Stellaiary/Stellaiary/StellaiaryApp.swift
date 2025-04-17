//
//  StellaiaryApp.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftUI
import SwiftData

@main
struct StellaiaryApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Dats.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //.modelContainer(sharedModelContainer)
        .modelContainer(for: [Dats.self, Cats.self])
    }
}

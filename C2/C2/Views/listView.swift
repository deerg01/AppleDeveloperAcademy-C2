//
//  listView.swift
//  C2
//
//  Created by POS on 4/8/25.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Query private var recs: [Recs]
    private let categories = Cats.allCases

    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { cat in
                    NavigationLink(destination: recListView(category: cat, recs: filteredRecs(for: cat))) {
                        Text(cat.name)
                    }
                }
            }
            .navigationTitle("도전 주제 목록")
        }
    }

    private func filteredRecs(for category: Cats) -> [Recs] {
        recs.filter { $0.category == category.rawValue }
    }
}

#Preview {
    ListView()
        .modelContainer(for: Recs.self)
}

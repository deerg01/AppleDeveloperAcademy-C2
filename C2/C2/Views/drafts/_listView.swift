//
//  listView.swift
//  C2
//
//  Created by POS on 4/8/25.
//
//  level이 0이거나 너무 낮은 경우 일정 임계치를 제공하기

import SwiftUI
import SwiftData

struct _listView: View {
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
    _listView()
        .modelContainer(for: Recs.self)
}

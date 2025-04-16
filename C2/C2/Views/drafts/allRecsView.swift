//
//  allRecsView.swift
//  C2
//
//  Created by POS on 4/9/25.
//
// view all containing data

import SwiftUI
import SwiftData

struct allRecsView: View {
    @Query(sort: \Recs.category) private var recs: [Recs]


    var body: some View {
        List {
            ForEach(recs, id: \.self) { rec in
                VStack(alignment: .leading) {
                    Text("title: \(rec.title)")
                    Text("content: \(rec.content)")
                        .font(.caption)
                    Text("category: \(rec.category)")
                        .font(.caption)
                    Text("level: \(rec.level, specifier: "%.1f")")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
        }
    }
}


#Preview {
    allRecsView()
}

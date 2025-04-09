//
//  recListView.swift
//  C2
//
//  Created by POS on 4/9/25.
//
// see all the records in category
// need to make :: deleting,

import SwiftUI

struct recListView: View {
    @State private var actionTitle: String? = nil
    @State private var editingRec: Recs? = nil
    
    let category: Cats
    let recs: [Recs]

    var body: some View {
        List(recs) { rec in
            Text(rec.title)

                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        if let index = recs.firstIndex(where: { $0.id == rec.id }) {
                                    recs[index].isDel = true
                                }
                    } label: {
                        Label("Trash", systemImage: "trash")
                    }
                    .tint(.red)

                    Button {
                        editingRec = rec
                    } label: {
                        Label("Edit", systemImage: "pencil.line")
                    }
                    .tint(.blue)
                }
                .sheet(item: $editingRec) { rec in
                    EditView(rec: rec)
                }
        }
        .navigationTitle(category.name)
        
    }
    
    

}

#Preview {
    ListView()
        .modelContainer(for: Recs.self)
}

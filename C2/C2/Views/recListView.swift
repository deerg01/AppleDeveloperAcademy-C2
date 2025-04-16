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
                        // 대 발 견 !! 무려 id없이도 냅다 rec로 불러내서 비교해도 @Modal이 자동으로 id감별해줌티비
                        if let index = recs.firstIndex(where: { $0 === rec }) {
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
                    editView(rec: rec)
                }
        }
        .navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    

}

#Preview {
    listView()
        .modelContainer(for: Recs.self)
}

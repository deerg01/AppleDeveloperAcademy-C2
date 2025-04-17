////
////  datListView.swift
////  Stellaiary
////
////  Created by POS on 4/17/25.
////
//// see all the records in category
//// need to make :: deleting,

import SwiftUI

struct datListView: View {
    @State private var actionTitle: String? = nil
    @State private var editingRec: Dats? = nil
    
    
    let category: String
    let dats: [Dats]

    var body: some View {
        List(dats) { dat in
            
            Text(dat.title)

                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        // 대 발 견 !! 무려 id없이도 냅다 rec로 불러내서 비교해도 @Modal이 자동으로 id감별해줌티비
                        if let index = dats.firstIndex(where: { $0 === dat }) {
                                    dats[index].isDel = true
                                }
                    } label: {
                        Label("Trash", systemImage: "trash")
                    }
                    .tint(.red)

                    Button {
                        editingRec = dat
                    } label: {
                        Label("Edit", systemImage: "pencil.line")
                    }
                    .tint(.blue)
                }
                .sheet(item: $editingRec) { dat in
                    //editView(dat: dat)
                }
        }
        //.navigationTitle(category.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    

}

#Preview {
    ContentView()
        .modelContainer(for: Dats.self)
}

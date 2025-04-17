//
//  listView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftData
import SwiftUI

struct listView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dats: [Dats]
    @Query private var cats: [Cats]

    @State private var isEditing: Bool = false
    @State private var delAlert: Bool = false

    var body: some View {
        ScrollView {
            NavigationView {
                List {
                    ForEach(Cats.sortCats(cats: cats)) { cat in
                        NavigationLink(destination: {
                            if !isEditing{
                                Text(cat.name)
                                datListView(
                                    category: cat.name,
                                    dats: Cats.datFilter(for: cat, from: dats)
                                )
                            }
                            else {
                                catModView()
                            }
                        }) {
                            // label에서 trash button 추가하기
                            if !isEditing {
                                Text(cat.name)
                                    .foregroundColor(.primary)
                            } else {
                                HStack {
                                    Text(cat.name)
                                        .foregroundColor(.primary)

                                    Spacer()

                                    if cat.name != "기타" {
                                        Button {
                                            delAlert = true
                                        } label: {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: delCat)
                }
            }
        }
    }
    
    private func delCat_(_ cat: Cats) {
        // 삭제된 카테고리 안의 데이터 '기타'로 옮기기
    }

    private func delCat(at offsets: IndexSet) {
        // 카테고리 삭제하기
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Dats.self, Cats.self])
}

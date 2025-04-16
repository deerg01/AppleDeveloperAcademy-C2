//
//  listView.swift
//  C2
//
//  Created by POS on 4/13/25.
//
// 얘 왜 swipeaction 있음 ?????/ Why???
// control box height : 320

import SwiftData
import SwiftUI

struct listView: View {
    @State private var isEditing = false

    @State private var delAlert = false
    @State private var selectedCategory: Cats? = nil
    @State private var showCatAdd = false

    @Environment(\.modelContext) private var modelContext
    @Query private var recs: [Recs]

    @State private var categories: [Cats] = Cats.allCases

    var body: some View {
        ScrollView {
            NavigationView {
                List {
                    ForEach(categories, id: \.self) { cat in
                        //전체의 큰 navigationlink 안에 분기 생성
                        NavigationLink(destination: {
                            if !isEditing {
                                recListView(
                                    category: cat,
                                    recs: filteredRecs(for: cat)
                                )
                            } else {
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

                                    if cat != .zz {
                                        Button {
                                            selectedCategory = cat
                                            delAlert = true
                                        } label: {
                                            Image(systemName: "trash")
                                                .foregroundColor(.sysRed)
                                        }
                                        .buttonStyle(BorderlessButtonStyle())
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteCategoryAt)

                    if !isEditing {  // category add button
                        ZStack {  // button on navigation link. 어차피 투명화로 배경 날릴거니까 밑부분 더럽게 잘린건 무시..
                            NavigationLink(
                                destination: catAddView(),
                                isActive: $showCatAdd
                            ) {
                                //EmptyView()
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.accentColor)
                            }
                            .hidden()

                            Button(action: {
                                showCatAdd = true
                            }) {
                                HStack {
                                    Spacer()
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.accentColor)
                                    Spacer()
                                }
                                .padding(.vertical, 8)
                            }
                            .listRowBackground(Color.clear)
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .alert(isPresented: $delAlert) {
                    Alert(
                        title: Text("정말로 삭제하시겠습니까?"),
                        message: Text("이 동작은 돌이킬 수 없습니다."),
                        primaryButton: .destructive(Text("삭제")) {
                            if let category = selectedCategory {
                                deleteCategory(category)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "완료" : "편집")
                            .tint(Color.sysPpl)
                    }
                }
            }
        }
    }

    private func filteredRecs(for category: Cats) -> [Recs] {
        recs.filter { $0.category == category.rawValue }
    }

    private func deleteCategory(_ category: Cats) {
        guard category != .zz else { return }

        for rec in recs where rec.category == category.rawValue {
            rec.category = "zz"
        }
        try? modelContext.save()

        categories.removeAll { $0 == category }
    }

    private func deleteCategoryAt(at offsets: IndexSet) {
        offsets.forEach { index in
            let category = categories[index]
            deleteCategory(category)
        }
    }
}

#Preview {
    listView()
        .modelContainer(for: Recs.self)
}

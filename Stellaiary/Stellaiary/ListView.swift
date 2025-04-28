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
    @State private var showCatAdd = false
    @State private var selectedCategory: Cats? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(Cats.sortCats(cats: cats)) { cat in
                    NavigationLink(destination: {
                        if !isEditing {
                            datListView(
                                category: cat.name,
                                dats: Cats.datFilter(for: cat, from: dats)
                            )
                        } else {
                            catModView(cat: cat)
                        }
                    }) {
                        // label에서 trash button 추가하기
                        if !isEditing {
                            Text(cat.name)
                                .font(.custom("IMHyemin-Bold", size: 17))
                                .foregroundColor(.primary)
                                .frame(maxHeight: .infinity, alignment: .center)
                        } else {
                            HStack {
                                Text(cat.name)
                                    .font(.custom("IMHyemin-Bold", size: 17))
                                    .foregroundColor(.primary)
                                    .frame(maxHeight: .infinity, alignment: .center)

                                Spacer()

                                if cat.name != "기타" {
                                    Button {
                                        selectedCategory = cat
                                        delAlert = true
                                    } label: {
                                        Image(systemName: "trash")
                                            .bold()
                                            .foregroundColor(Color.sysRed)
                                    }
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }

                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 26, leading: 20, bottom: 26, trailing: 20))
                }

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
                    }
                    .listRowBackground(Color.clear)
                }
            }
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .white, location: 0.00),
                        Gradient.Stop(
                            color: Color(red: 0.6, green: 0.6, blue: 0.6),
                            location: 1.00
                        ),
                    ],
                    startPoint: UnitPoint(x: 0.04, y: 0),
                    endPoint: UnitPoint(x: 1, y: 1)
                )
            )
            .scrollContentBackground(.hidden)
            .alert(isPresented: $delAlert) {
                Alert(
                    title: Text("정말로 삭제하시겠습니까?"),
                    message: Text("이 동작은 돌이킬 수 없습니다."),
                    primaryButton: .destructive(Text("삭제")) {
                        if let category = selectedCategory {
                            delCat(category)
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
                }
            }
        }
    }

    private func delCat(_ category: Cats) {
        delCat_(category)
        modelContext.delete(category)

        do {
            try modelContext.save()
        } catch {
            print("Error deleting category: \(error)")
        }
    }

    private func delCat_(_ cat: Cats) {
        guard let Cat_ = cats.first(where: { $0.name == "기타" }) else { return }
        // move data into 'Others'
        for dat in dats where dat.category == cat.name {
            dat.category = Cat_.name
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Dats.self, Cats.self])
}

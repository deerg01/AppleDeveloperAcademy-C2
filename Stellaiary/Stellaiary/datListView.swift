//
//  datListView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftUI

struct datListView: View {
    @Environment(\.modelContext) private var modelContext

    let category: String
    let dats: [Dats]

    @State private var isEditing = false
    @State private var datToDelete: Dats? = nil
    @State private var selectedDat: Dats? = nil
    @State private var toEdit = false

    var body: some View {
        List {
            ForEach(dats.filter { !$0.isDel }) { dat in
                HStack {
                    VStack(alignment: .leading) {
                        Text(dat.title)
                            .font(.headline)
                        Text(dat.date.formatted(date: .abbreviated, time: .omitted))
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    if isEditing {
                        Button {
                            datToDelete = dat
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.borderless) // 이거 없으면 Button과 Cell 선택이 중복인식됨
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    if !isEditing {
                        selectedDat = dat
                        toEdit = true
                    }
                }
            }
        }
        .alert(item: $datToDelete) { dat in
            Alert(
                title: Text("삭제하시겠습니까?"),
                primaryButton: .destructive(Text("삭제")) {
                    if let index = dats.firstIndex(where: { $0 === dat }) {
                        dats[index].isDel = true
                    }
                },
                secondaryButton: .cancel {
                    datToDelete = nil
                }
            )
        }
        .background(
            NavigationLink(
                destination: selectedDat.map { editView(dat: $0) },
                isActive: $toEdit,
                label: { EmptyView() }
            )
            .hidden()
        )
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(isEditing ? "완료" : "편집") {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
            }
        }
    }
}




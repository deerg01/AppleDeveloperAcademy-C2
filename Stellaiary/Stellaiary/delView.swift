//
//  delView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftUI
import SwiftData

struct delView: View {
    @Query private var allDats: [Dats]
    @Environment(\.modelContext) private var modelContext

    @State private var delAlert = false
    @State private var emptAlert = false

    var body: some View {
        VStack {
            List {
                ForEach(trashedDats) { dat in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(dat.title)
                            .font(.headline)

                        Text(dat.date.formatted(date: .abbreviated, time: .omitted))
                            .font(.subheadline)
                            .foregroundColor(.gray)

                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            dat.isDel = false
                        } label: {
                            Label("복구", systemImage: "arrow.uturn.backward")
                        }
                        .tint(.blue)
                    }
                }
            }
            .alert("휴지통을 비우시겠습니까?", isPresented: $delAlert) {
                Button("삭제", role: .destructive) {
                    emptyTrash()
                }
                Button("취소", role: .cancel) {}
            } message: {
                Text("이 동작은 돌이킬 수 없습니다.")
            }
            .alert("휴지통은 비어있습니다", isPresented: $emptAlert) {
                Button("확인", role: .cancel) {}
            }
        }
        .navigationTitle("휴지통")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(role: .destructive) {
                    if trashedDats.isEmpty {
                        emptAlert = true
                    } else {
                        delAlert = true
                    }
                } label: {
                    Text("삭제")
                        .tint(Color.sysRed)
                }
            }
        }
    }

    private var trashedDats: [Dats] {
        allDats.filter { $0.isDel }
    }

    private func emptyTrash() {
        for dat in trashedDats {
            modelContext.delete(dat)
        }
        try? modelContext.save()
    }
}

#Preview {
    delView()
        .modelContainer(for: [Dats.self])
}

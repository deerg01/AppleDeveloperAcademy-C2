//
//  delView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftData
import SwiftUI

struct delView: View {
    @Query private var allDats: [Dats]
    @Environment(\.modelContext) private var modelContext

    @State private var delAlert = false
    @State private var emptAlert = false
    @State private var selectedDat: Dats? = nil

    var body: some View {
        VStack {
            List {
                ForEach(trashedDats) { dat in
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(dat.title)
                                .font(.headline)

                            Text(
                                dat.date.formatted(
                                    date: .abbreviated,
                                    time: .omitted
                                )
                            )
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        }

                        Spacer()

                        if selectedDat === dat {
                            Button {
                                dat.isDel = false
                                selectedDat = nil
                            } label: {
                                Label("복구", systemImage: "arrow.uturn.backward")
                                    .labelStyle(IconOnlyLabelStyle())
                            }
                            .padding(.trailing, 8)

                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    .listRowBackground(Color.clear)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation {
                            selectedDat = (selectedDat === dat) ? nil : dat
                        }
                    }
                }
            }
            .background(
                LinearGradient(
                    stops: [
                        Gradient.Stop(
                            color: Color(red: 0.78, green: 0.78, blue: 0.8),
                            location: 0.00
                        ),
                        Gradient.Stop(
                            color: Color(red: 0.62, green: 0.6, blue: 0.67),
                            location: 1.00
                        ),
                    ],
                    startPoint: UnitPoint(x: 0.04, y: 0.02),
                    endPoint: UnitPoint(x: 0.66, y: 0.5)
                )
            )
            .scrollContentBackground(.hidden)

            .alert("쓰레기통을 비우시겠습니까?", isPresented: $delAlert) {
                Button("삭제", role: .destructive) {
                    emptyTrash()
                }
                Button("취소", role: .cancel) {}
            } message: {
                Text("이 동작은 돌이킬 수 없습니다.")
            }
            .alert("쓰레기통은 비어있습니다", isPresented: $emptAlert) {
                Button("확인", role: .cancel) {}
            }

        }
        .navigationTitle("쓰레기통")
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
                        .bold()
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

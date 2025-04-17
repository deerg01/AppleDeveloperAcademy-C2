//
//  catEdit.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftData
import SwiftUI

struct catAddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Query private var cats: [Cats]

    @State private var titleInput: String = ""
    @State private var selectedColor: String = "picGreen"
    @State private var showDupAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Text("도전 주제: ")

                    TextField("파이팅! 목표를 설정해바요", text: $titleInput)
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }

                Divider()

                HStack {
                    Text("색상: ")
                    Spacer()
                }

                colorPicker(selectedColor: $selectedColor)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가") {
                        if cats.contains(where: { $0.name == titleInput }) {
                            showDupAlert = true
                        } else {
                            let newCat = Cats(
                                name: titleInput,
                                color: "." + selectedColor
                            )
                            modelContext.insert(newCat)
                            dismiss()
                        }
                    }
                    .tint(.blue)
                    .disabled(titleInput.isEmpty)
                }
            }
            .alert("이미 존재하는 주제입니다", isPresented: $showDupAlert) {
                Button("확인", role: .cancel) {}
            }
        }
    }
}

struct catModView: View {
    @Bindable var cat: Cats
    @Environment(\.dismiss) private var dismiss
    @Query private var cats: [Cats]
    
    @State private var titleInput: String = ""
    @State private var selectedColor: String = ""
    @State private var showDupAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HStack {
                    Text("도전 주제: ")

                    TextField("이름 수정", text: $titleInput)
                        .padding(8)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }

                Divider()

                HStack {
                    Text("색상: ")
                    Spacer()
                }

                colorPicker(selectedColor: $selectedColor)
                    .onAppear {
                        titleInput = cat.name
                        selectedColor = cat.color.replacingOccurrences(of: ".", with: "")
                    }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("저장") {
                        let isDuplicate = cats.contains {
                            $0.name == titleInput && $0.id != cat.id
                        }

                        if isDuplicate {
                            showDupAlert = true
                        } else {
                            cat.name = titleInput
                            cat.color = "." + selectedColor
                            dismiss()
                        }
                    }
                    .tint(.blue)
                }
            }
            .alert("이미 존재하는 주제입니다", isPresented: $showDupAlert) {
                Button("확인", role: .cancel) {}
            }
        }
    }
}

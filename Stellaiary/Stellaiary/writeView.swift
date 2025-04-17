//
//  writeView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//
//  write의 control box height : 565

import SwiftUI
import SwiftData

struct writeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @Query private var cats: [Cats]

    @State private var selectedCat: Cats? = nil
    @State private var cttInput: String = ""
    @State private var titleInput: String = ""
    @State private var sliderValue: Float = 70.0
    @State private var wDate: Date = Date()

    @State private var isEditing = false
    @State private var showAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 13) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("도전 주제: ")
                        .font(.headline)

                    Picker("도전 주제", selection: $selectedCat) {
                        ForEach(cats) { cat in
                            Text(cat.name).tag(Optional(cat))
                        }
                    }
                    .pickerStyle(.menu)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .tint(Color.sysPpl)
                }

                HStack {
                    Text("제목: ")
                        .font(.headline)

                    Spacer()

                    TextField("제목을 요기요깅", text: $titleInput)
                        .padding(8)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }

                Divider().background(Color.white.opacity(0.3))

                VStack(alignment: .leading, spacing: 3) {
                    Text("성취도: ")
                        .font(.headline)

                    Slider(
                        value: $sliderValue,
                        in: 0...100,
                        onEditingChanged: { editing in
                            isEditing = editing
                        }
                    )
                    .tint(Color.sysPpl)
                }

                Divider().background(Color.white.opacity(0.3))

                VStack(alignment: .leading, spacing: 8) {
                    Text("메모: ")
                        .font(.headline)

                    TextEditor(text: $cttInput)
                        .frame(height: 160)
                        .padding(8)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.sysPpl.opacity(0.4), lineWidth: 1)
                        )
                }

                Button(action: {
                    if titleInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        showAlert = true
                        return
                    }

                    let newData = Dats(
                        category: selectedCat!.name,
                        title: titleInput,
                        content: cttInput,
                        level: sliderValue,
                        date: wDate
                    )

                    modelContext.insert(newData)

                    cttInput = ""
                    titleInput = ""
                    sliderValue = 70.0

                    dismiss()
                }) {
                    Text("저장")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.sysPpl)
                        .foregroundColor(.white)
                        .cornerRadius(3)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("제목을 입력해주세요", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
        .background(Color.clear)
        .onAppear {
            // default catrgory sets to "Others"
            if selectedCat == nil {
                selectedCat = cats.first(where: { $0.name == "기타" }) ?? cats.first
            }
        }
    }
}

#Preview {
    writeView()
        .modelContainer(for: [Dats.self, Cats.self])
}

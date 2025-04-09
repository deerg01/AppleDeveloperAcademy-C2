//
//  writeView.swift
//  C2
//
//  Created by POS on 4/8/25.
//

import SwiftUI
import SwiftData

struct writeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    
    @State private var selectedCat: Cats = .zz
    @State private var cttInput: String = ""
    @State private var titleInput: String = ""
    @State private var sliderValue: Float = 50.0

    @State private var isEditing = false
    @State private var showAlert = false


    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("도전 주제")
                    .font(.headline)
                
                Picker("도전 주제", selection: $selectedCat) {
                    ForEach(Cats.allCases) { cat in
                        Text(cat.name).tag(cat)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }

            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("도전 제목")
                    .font(.headline)
                TextField("제목을 요기요깅", text: $titleInput)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            
            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("성취도")
                    .font(.headline)
                
                Slider(
                    value: $sliderValue,
                    in: 0...100,
                    onEditingChanged: { editing in
                        isEditing = editing
                    }
                )
            }

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("메모")
                    .font(.headline)

                TextEditor(text: $cttInput)
                    .frame(height: 150)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
            }

            Spacer()

            Button(action: {
                if titleInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    showAlert = true // title can't be empty
                    return
                }

                let newRec = Recs(
                    category: selectedCat.rawValue,
                    title: titleInput,
                    content: cttInput,
                    level: sliderValue
                )

                modelContext.insert(newRec)

                // initialize
                cttInput = ""
                titleInput = ""
                sliderValue = 0.0

                dismiss()
            }) {
                Text("저장")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
        .padding()
        .alert("제목을 입력해주세요", isPresented: $showAlert) {
            Button("확인", role: .cancel) { }
        }
    }
}

#Preview {
    writeView()
}

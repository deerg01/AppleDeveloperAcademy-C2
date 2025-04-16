//
//  newwriteView.swift
//  C2
//
//  Created by POS on 4/13/25.
//
//  write의 control box height : 565
//
import SwiftUI
import SwiftData

struct writeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @State private var selectedCat: Cats = .zz
    @State private var cttInput: String = ""
    @State private var titleInput: String = ""
    @State private var sliderValue: Float = 70.0

    @State private var isEditing = false
    @State private var showAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 13) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("도전 주제: ")
                        .font(.headline)

                    Picker("도전 주제", selection: $selectedCat) {
                        ForEach(Cats.allCases) { cat in
                            Text(cat.name).tag(cat)
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
                        //.background(.ultraThinMaterial)
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
                        //.foregroundColor(.blue)

                    TextEditor(text: $cttInput)
                        .frame(height: 160)
                        .padding(8)
                        //.background(.ultraThinMaterial)
                        .cornerRadius(10)
                        //.foregroundColor(.white)
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

                    let newRec = Recs(
                        category: selectedCat.rawValue,
                        title: titleInput,
                        content: cttInput,
                        level: sliderValue,
                    )

                    modelContext.insert(newRec)

                    cttInput = ""
                    titleInput = ""
                    sliderValue = 70.0

                    dismiss()
                }) {
                    // 저장버튼 누르면 dissmiss가 아니라 starView로 날아가게 하는 방법 찾아야 함
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
    }
}

#Preview {
    writeView()
} 

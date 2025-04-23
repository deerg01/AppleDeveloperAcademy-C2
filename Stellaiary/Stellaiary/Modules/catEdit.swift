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
        CatEditorView(
            isEditing: false,
            isOther: false,
            titleInput: $titleInput,
            selectedColor: $selectedColor,
            showDupAlert: $showDupAlert,
            existingNames: cats.map { $0.name },
            confirmButtonTitle: "추가"
        ) {
            let newCat = Cats(name: titleInput, color: "." + selectedColor)
            modelContext.insert(newCat)
            dismiss()
        }
    }
}

struct catModView: View {
    @Environment(\.dismiss) private var dismiss
    @Query private var cats: [Cats]
    @Bindable var cat: Cats

    @State private var titleInput: String = ""
    @State private var selectedColor: String = ""
    @State private var showDupAlert = false

    private var isOther: Bool { cat.name == "기타" }

    var body: some View {
        CatEditorView(
            isEditing: true,
            isOther: isOther,
            titleInput: $titleInput,
            selectedColor: $selectedColor,
            showDupAlert: $showDupAlert,
            existingNames: cats.filter { $0.id != cat.id }.map { $0.name },
            confirmButtonTitle: "저장"
        ) {
            cat.name = titleInput
            cat.color = "." + selectedColor
            dismiss()
        }
        .onAppear {
            titleInput = cat.name
            selectedColor = cat.color.replacingOccurrences(of: ".", with: "")
        }
    }
}

// common UI
struct CatEditorView: View {
    let isEditing: Bool
    let isOther: Bool
    @Binding var titleInput: String
    @Binding var selectedColor: String
    @Binding var showDupAlert: Bool
    let existingNames: [String]
    let confirmButtonTitle: String
    let onSave: () -> Void

    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: .white, location: 0),
                    .init(color: Color.gray, location: 1)
                ],
                startPoint: UnitPoint(x: 0.04, y: 0),
                endPoint: UnitPoint(x: 1, y: 1)
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Text("도전 주제: ")

                    if isOther {
                        HStack {
                            Text("기타")
                            Image(systemName: "lock.fill")
                        }
                        .modifier(LockedFieldModifier())
                    } else {
                        TextField("파이팅! 목표를 설정해바요", text: $titleInput)
                            .modifier(EditFieldModifier())
                    }
                }

                Divider()

                HStack {
                    Text("색상: ")
                    Spacer()
                }

                colorPicker(selectedColor: $selectedColor)
            }
            .padding()
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(confirmButtonTitle) {
                    let isDup = existingNames.contains {
                        $0 == titleInput
                    }

                    if isDup {
                        showDupAlert = true
                    } else {
                        onSave()
                    }
                }
                .tint(.accentColor)
                .disabled(titleInput.isEmpty && !isOther)
            }
        }
        .alert("이미 존재하는 주제입니다", isPresented: $showDupAlert) {
            Button("확인", role: .cancel) {}
        }
    }
}


struct EditFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .foregroundColor(.black)
    }
}

struct LockedFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .foregroundColor(.black)
    }
}

//
//  writeView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//
// 주제피커 전체 영역 터치 가능하게
// 별의 투명도를 실시간으로 볼 수 있게 

import SwiftData
import SwiftUI
import SwiftUIIntrospect

struct writeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss

    @Query private var cats: [Cats]

    @State private var selectedCat: Cats? = nil
    @State private var cttInput: String = ""
    @State private var titleInput: String = ""
    @State private var sliderValue: Double = 0.70
    @State private var wDate: Date = Date()

    @State private var isEditing = false
    @State private var showAlert = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 13) {
                categoryPicker
                titleField
                Divider().background(Color.white.opacity(0.3))
                levelSlider
                Divider().background(Color.white.opacity(0.3))
                memoEditor
                launchButton
            }
            .onTapGesture {
                hideKey()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("제목을 입력하세요", isPresented: $showAlert) {
            Button("확인", role: .cancel) {}
        }
        .background(
            Image("paper")
                .frame(width: 353, height: 565)
        )
        .onAppear {
            if selectedCat == nil {
                selectedCat =
                    cats.first(where: { $0.name == "기타" }) ?? cats.first
            }

            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
            navBarAppearance.backgroundEffect = UIBlurEffect(
                style: .systemUltraThinMaterial
            )
            navBarAppearance.backgroundColor = UIColor.systemBackground
                .withAlphaComponent(0.25)

            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        .introspect(.viewController, on: .iOS(.v16, .v17)) { viewController in
            viewController.view.backgroundColor = .clear
        }
    }

    private var categoryPicker: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("도전 주제: ")
                .font(.custom("IMHyemin-Bold", size: 17))

            Menu {
                ForEach(cats) { cat in
                    Button {
                        selectedCat = cat
                    } label: {
                        Text(cat.name)
                            .foregroundColor(.accentColor)
                    }
                }
            } label: {
                HStack {
                    Text(selectedCat?.name ?? "도전 주제를 선택하세요")
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.87, green: 0.87, blue: 0.87).opacity(0.7))
                .cornerRadius(10)
            }
        }
    }


    private var titleField: some View {
        HStack {
            Text("제목: ")
                .font(.custom("IMHyemin-Bold", size: 17))

            Spacer()

            TextField("제목을 요기요깅", text: $titleInput)
                .padding(8)
                .cornerRadius(10)
        }
    }

    private var levelSlider: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("성취도: ")
                .font(.custom("IMHyemin-Bold", size: 17))

            Slider(
                value: $sliderValue,
                in: 0.12...1,
                onEditingChanged: { editing in
                    isEditing = editing
                }
            )
            .tint(.accentColor)
        }
    }

    private var memoEditor: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("메모: ")
                .font(.custom("IMHyemin-Bold", size: 17))

            TextEditor(text: $cttInput)
                .scrollContentBackground(.hidden)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            Color(red: 0.87, green: 0.87, blue: 0.87).opacity(
                                0.5
                            )
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.sysPpl.opacity(0.4), lineWidth: 1)
                )
                .frame(height: 160)
        }
    }

    private var launchButton: some View {
        Button(action: {
            if titleInput.trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
            {
                showAlert = true
                return
            }

            guard let selectedCat = selectedCat else {
                showAlert = true
                return
            }
            
            
            let newData = Dats(
                category: selectedCat.name,
                title: titleInput,
                content: cttInput,
                level: sliderValue,
                date: wDate
            )

            modelContext.insert(newData)

            cttInput = ""
            titleInput = ""
            sliderValue = 0.70

            dismiss()
        }) {
            Text("Launch!")
                .frame(maxWidth: .infinity)
                .padding()
                .background(.sysPpl)
                .foregroundColor(.white)
                .cornerRadius(3)
        }
    }
}

extension View {
    func hideKey() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}

#Preview {
    writeView()
        .modelContainer(for: [Dats.self, Cats.self])
}

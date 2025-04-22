//
//  editView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftData
import SwiftUI
import SwiftUIIntrospect


struct editView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query private var cats: [Cats]
    @Bindable var dat: Dats

    @State private var tempTitle: String = ""
    @State private var tempContent: String = ""
    @State private var tempCategory: String = ""
    @State private var tempDate: Date = Date()
    @State private var tempLevel: Double = 0.70

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 13) {
                categorySection
                titleField
                Divider().background(Color.white.opacity(0.3))
                levelSlider
                Divider().background(Color.white.opacity(0.3))
                memoEditor
                updateButton
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .background(Image("paper"))
            .onAppear(perform: initializeFields)
            .introspect(.viewController, on: .iOS(.v16, .v17)) { $0.view.backgroundColor = .clear }
        }
    }

    private var categorySection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("도전 주제:")
                    .font(.custom("IMHyemin-Bold", size: 17))

                DatePicker("", selection: $tempDate, displayedComponents: .date)
                    .datePickerStyle(.compact)
            }

            Menu {
                ForEach(cats) { cat in
                    Button {
                        tempCategory = cat.name
                    } label: {
                        Text(cat.name)
                            .foregroundColor(.accentColor)
                    }
                }
            } label: {
                HStack {
                    Text(tempCategory.isEmpty ? "도전 주제를 선택하세요" : tempCategory)
                        .foregroundColor(tempCategory.isEmpty ? .gray : .primary)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            }
        }
    }

    

    private var titleField: some View {
        HStack {
            Text("제목: ")
                .font(.custom("IMHyemin-Bold", size: 17))

            Spacer()

            TextField("어떤 도전을 하셨나요?", text: $tempTitle)
                .padding(8)
                .cornerRadius(10)
                .foregroundColor(.black)
        }
    }

    private var levelSlider: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("성취도: ")
                .font(.custom("IMHyemin-Bold", size: 17))

            Slider(value: $tempLevel, in: 0.12...1)
                .tint(.accentColor)
        }
    }

    private var memoEditor: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("메모: ")
                .font(.custom("IMHyemin-Bold", size: 17))

            TextEditor(text: $tempContent)
                .scrollContentBackground(.hidden)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.sysPpl.opacity(0.4), lineWidth: 1)
                )
                .frame(height: 160)
        }
    }

    private var updateButton: some View {
        Button("수정 완료") {
            updateDat()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.sysPpl)
        .foregroundColor(.white)
        .cornerRadius(3)
    }

    private func initializeFields() {
        tempTitle = dat.title
        tempContent = dat.content
        tempCategory = dat.category.isEmpty ? (cats.first?.name ?? "기타") : dat.category
        tempDate = dat.date
        tempLevel = dat.level

        applyNavigationAppearance()
    }

    private func updateDat() {
        dat.title = tempTitle
        dat.content = tempContent
        dat.category = tempCategory
        dat.date = tempDate
        dat.level = tempLevel

        try? modelContext.save()
        dismiss()
    }

    private func applyNavigationAppearance() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        navBarAppearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.25)

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
}


#Preview {
    @State var dummy = Dats(category: "기타", title: "테스트", content: "내용", level: 0.50)

    return editView(dat: dummy)
        .modelContainer(for: [Dats.self, Cats.self])
}

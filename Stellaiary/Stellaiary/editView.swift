//
//  editView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//


import SwiftUI
import SwiftData

struct editView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Query private var cats: [Cats]

    @Bindable var dat: Dats

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 13) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("도전 주제:")
                            .font(.headline)
                        
                        DatePicker(
                            "" /* Date Picker의 라벨 꼭 필요할까? 괜찮은데.. */,
                            selection: $dat.date,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                    }
                    
                    Picker("도전 주제", selection: $dat.category) {
                        ForEach(cats) { cat in
                            Text(cat.name).tag(cat.name)
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
                    
                    TextField("제목을 요기요깅", text: $dat.title)
                        .padding(8)
                        .cornerRadius(10)
                        .foregroundColor(.black)
                }
                
                Divider().background(Color.white.opacity(0.3))
                
                VStack(alignment: .leading, spacing: 3) {
                    Text("성취도: ")
                        .font(.headline)
                    
                    Slider(value: $dat.level, in: 0...100)
                        .tint(Color.sysPpl)
                }
                
                Divider().background(Color.white.opacity(0.3))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("메모: ")
                        .font(.headline)
                    
                    TextEditor(text: $dat.content)
                        .frame(height: 160)
                        .padding(8)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.sysPpl.opacity(0.4), lineWidth: 1)
                        )
                }
                
                Button("수정 완료") {
                    try? modelContext.save()
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.sysPpl)
                .foregroundColor(.white)
                .cornerRadius(3)
            }
            .padding()
            .onAppear {
                if dat.category.isEmpty {
                    dat.category = cats.first?.name ?? "기타"
                }
            }
        }
    }
}

#Preview {
    @State var dummy = Dats(category: "기타", title: "테스트", content: "내용", level: 50.0)

    return editView(dat: dummy)
        .modelContainer(for: [Dats.self, Cats.self])
}

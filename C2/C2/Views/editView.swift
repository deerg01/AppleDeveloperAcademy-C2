//
//  editView.swift
//  C2
//
//  Created by POS on 4/9/25.
//
// updating existing challenge memo

import SwiftData
import SwiftUI

struct editView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var date = Date()

    @Bindable var rec: Recs

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("도전 주제: ")
                        .font(.headline)

                    DatePicker(
                        "" /* Date Picker의 라벨 꼭 필요할까? 괜찮은데.. */,
                        selection: $date,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)

                }

                Picker("도전 주제", selection: $rec.category) {
                    ForEach(Cats.allCases) { cat in
                        Text(cat.name).tag(cat.rawValue)
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
                    .foregroundColor(.black)

                Spacer()

                TextField("제목을 요기요깅", text: $rec.title)
                    .padding(8)
                    //.background(Color(.systemGray6))
                    .cornerRadius(10)
                    .foregroundColor(.black)

            }

            Divider().background(Color.white.opacity(0.3))

            VStack(alignment: .leading, spacing: 3) {
                Text("성취도: ")
                    .font(.headline)

                Slider(
                    value: $rec.level,
                    in: 0...100,

                )
                .tint(Color.sysPpl)
            }

            Divider().background(Color.white.opacity(0.3))

            VStack(alignment: .leading, spacing: 8) {
                Text("메모: ")
                    .font(.headline)

                TextEditor(text: $rec.content)
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
    }
}

#Preview {
    listView()
        .modelContainer(for: Recs.self)
}

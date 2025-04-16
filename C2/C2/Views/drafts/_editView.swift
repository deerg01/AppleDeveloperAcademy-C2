//
//  editView.swift
//  C2
//
//  Created by POS on 4/9/25.
//
// updating existing challenge memo

import SwiftUI
import SwiftData

struct _editView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @Bindable var rec: Recs

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("도전 주제")
                    .font(.headline)

                Picker("도전 주제", selection: $rec.category) {
                    ForEach(Cats.allCases) { cat in
                        Text(cat.name).tag(cat.rawValue)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }

            Divider()
            
            VStack(alignment: .leading, spacing: 8){
                Text("도전 제목")
                    .font(.headline)
                TextField("제목을 요기요깅", text: $rec.title)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
            }
            
            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("성취도")
                    .font(.headline)

                Slider(value: $rec.level, in: 0...100)
            }

            Divider()

            VStack(alignment: .leading, spacing: 8) {
                Text("메모")
                    .font(.headline)

                TextEditor(text: $rec.content)
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

            Button("수정 완료") {
                try? modelContext.save()
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
    }
}



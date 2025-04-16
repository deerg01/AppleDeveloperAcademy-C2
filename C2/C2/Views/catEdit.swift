//
//  catEditView.swift
//  C2
//
//  Created by POS on 4/15/25.
//

import SwiftData
import SwiftUI

struct catModView: View {
    // cats 알잘딱 불러와서 데이터 바인딩
    @State private var titleInput: String = ""

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

                ColPicker()

            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Text("저장") //버튼으로 구현해야함
                    .tint(.blue)
            }
        }
    }
}

struct catAddView: View {
    @State private var titleInput: String = ""

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
                ColPicker()
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Text("추가") //버튼으로 구현해야함
                    .tint(.blue)
            }
        }
    }
}

#Preview {
    catModView()

    Divider()
    Divider()

    catAddView()
}

//
//  controlView.swift
//  C2
//
//  Created by POS on 4/14/25.
//


import SwiftData
import SwiftUI

//import SwiftUIIntrospect <<- 라이브러리 설치 시도해보기

struct controlView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recs: [Recs]

    @GestureState private var dragOffset: CGSize = .zero

    var body: some View {
        VStack {
            Spacer()

            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.ultraThinMaterial)
                .frame(height: 565)
                .overlay(
                    NavigationStack {
                        VStack(spacing: 16) {
                            NavigationLink(destination: writeView()) {
                                HStack {
                                    Text("새 도전 작성하기")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.blue)
                            }
                            Divider()

                            NavigationLink(destination: listView()) {
                                HStack {
                                    Text("도전 기록 보기")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.blue)
                            }
                            Divider()

                            NavigationLink(destination: delView()) {
                                HStack {
                                    Text("쓰레기통")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 20)
                    }
                    // stack의 background 어떻게 날려버릴 수 있을까...
                )
                .padding(.horizontal, 24)
                .shadow(radius: 10)
                .offset(x: dragOffset.width)

            Spacer()
        }
    }
}

#Preview {
    controlView()
}

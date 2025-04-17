//
//  controlbox.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftData
import SwiftUI

struct controlbox: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dats: [Dats]
    @Query private var cats: [Cats]

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
    controlbox()
}

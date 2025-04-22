//
//  controlbox.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftData
import SwiftUI
import SwiftUIIntrospect

struct controlbox: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dats: [Dats]
    @Query private var cats: [Cats]

    @GestureState private var dragOffset: CGSize = .zero

    var body: some View {
        VStack(spacing: 20) {
            NavigationLink(destination: writeView()) {
                HStack {
                    Text("새 도전 작성하기")

                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.black)

            }

            Divider()

            NavigationLink(destination: listView()) {
                HStack {
                    Text("도전 기록 보기")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.black)
            }

            Divider()

            NavigationLink(destination: delView()) {
                HStack {
                    Text("쓰레기통")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundColor(.black)
            }

        }
        .padding(.horizontal)
        .padding(.horizontal, 30)
        .padding(.vertical, 20)
        .frame(maxWidth: 353, maxHeight: 255)
        .background(
            LinearGradient(
                stops: [
                    Gradient.Stop(color: .white, location: 0.00),
                    Gradient.Stop(
                        color: Color(red: 0.6, green: 0.6, blue: 0.6),
                        location: 1.00
                    ),
                ],
                startPoint: UnitPoint(x: 0.04, y: 0),
                endPoint: UnitPoint(x: 1, y: 1)
            )
        )
        .cornerRadius(11)
        .overlay(
            RoundedRectangle(cornerRadius: 11)
                .inset(by: 0.5)
                .stroke(.white, lineWidth: 1)

        )
    }

}

#Preview {
    controlbox()
}

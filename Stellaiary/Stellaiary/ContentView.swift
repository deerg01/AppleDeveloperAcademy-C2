//
//  ContentView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import ComposableArchitecture
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dats: [Dats]
    @Query private var cats: [Cats]

    var body: some View {
        TabView {
            ZStack {
                Image("backL")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -223, y: 0) //GOD 해냈습니다 근데 기종마다 알맞게 설정하려면?
                    .ignoresSafeArea()

                ControlBoxWrapper { //너는 뭐하는애니 ?-?
                    controlbox()
                }
            }
            .tag(0)
            
            ZStack {
                Image("backR")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .offset(x: 142, y: 0)
                    .ignoresSafeArea()

                starView()
            }
            .tag(1)
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)  // for TapView sys area

        .onAppear {
            Cats.initDefaultsIfNeeded(in: modelContext, existing: cats)
        }
    }
}

struct ControlBoxWrapper<Content: View>: View {
    let content: () -> Content

    var body: some View {
        content()
            .frame(maxWidth: 353, maxHeight: 300)
            .cornerRadius(11)
    }
}

// keyboard hiding
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// default Category setup
extension Cats {
    static func initDefaultsIfNeeded(
        in context: ModelContext,
        existing cats: [Cats]
    ) {
        guard cats.isEmpty else { return }

        let defaults: [Cats] = [
            Cats(name: "공부", color: ".c1"),
            Cats(name: "취미", color: ".c3"),
            Cats(name: "건강", color: ".c6"),
            Cats(name: "기타", color: ".c7"),
//            Cats(name: "교류", color: ".picRed"),
//            Cats(name: "지울 항목", color: ".picYellow"),
        ]

        defaults.forEach { context.insert($0) }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Dats.self, Cats.self])
}

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
        //        ZStack {
        //            BackgroundGradientView()

        TabView {
            ZStack {
                Image("backL")
                    .resizable()
                    //.renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -223, y: 0) //GOD 해냈습니다 근데 기종마다 알맞게 설정하려면?
                    .ignoresSafeArea()

                ControlBoxWrapper {
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
        //}
        .onAppear {
            Cats.initDefaultsIfNeeded(in: modelContext, existing: cats)
        }
    }
}

struct BackgroundGradientView: View {
    var body: some View {
        //        LinearGradient(
        //            stops: [
        //                .init(color: Color(red: 0.14, green: 0.11, blue: 0.3), location: 0),
        //                .init(color: Color(red: 0, green: 0.45, blue: 1), location: 1),
        //            ],
        //            startPoint: UnitPoint(x: 0.5, y: 0.37),
        //            endPoint: UnitPoint(x: 0.5, y: 1)
        //        )
        //        .ignoresSafeArea()
        //        EllipticalGradient(
        //        stops: [
        //        Gradient.Stop(color: Color(red: 0.1, green: 0.39, blue: 0.71), location: 0.00),
        //        Gradient.Stop(color: Color(red: 0.01, green: 0.18, blue: 0.59), location: 0.26),
        //        Gradient.Stop(color: Color(red: 0.07, green: 0.03, blue: 0.28), location: 0.88),
        //        ],
        //        center: UnitPoint(x: 0.5, y: 0.39)
        //        )
        //        .ignoresSafeArea()
        Image("backImgae")  // backgroundImage는 이미지 파일 이름
            .resizable()
            //.scaledToFill()
            //.clipped()
            .ignoresSafeArea()
    }
}

struct ControlBoxWrapper<Content: View>: View {
    let content: () -> Content

    var body: some View {
        content()
            .frame(maxWidth: 353, maxHeight: 400)
            .cornerRadius(11)
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
            Cats(name: "자기계발", color: ".picBlue"),
            Cats(name: "취미", color: ".picPink"),
            Cats(name: "건강", color: ".picGreen"),
            Cats(name: "교류", color: ".picRed"),
            Cats(name: "기타", color: ".picYellow"),
            Cats(name: "지울 항목", color: ".picYellow"),
        ]

        defaults.forEach { context.insert($0) }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Dats.self, Cats.self])
}

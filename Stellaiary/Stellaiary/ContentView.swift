//
//  ContentView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dats: [Dats]
    @Query private var cats: [Cats]

    var body: some View {
        //NavigationStack { // starView만들어야하는
        ZStack {
            LinearGradient(  // background
                stops: [
                    Gradient.Stop(
                        color: Color(red: 0.14, green: 0.11, blue: 0.3),
                        location: 0.00
                    ),
                    Gradient.Stop(
                        color: Color(red: 0, green: 0.45, blue: 1),
                        location: 1.00
                    ),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0.37),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea()

            controlbox()
        //}
        }
        .onAppear {
            defaultCats()
        }
    }

    func defaultCats() {
        guard cats.isEmpty else { return }

        let defaults: [Cats] = [
            Cats(name: "자기계발", color: ".picBlue"),
            Cats(name: "취미", color: ".picPink"),
            Cats(name: "건강", color: ".picGreen"),
            Cats(name: "교류", color: ".picRed"),
            Cats(name: "기타", color: ".picYellow"),
            
            Cats(name: "지울 항목", color: ".picYellow"),
        ]
        defaults.forEach { modelContext.insert($0) }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Dats.self, Cats.self])
}

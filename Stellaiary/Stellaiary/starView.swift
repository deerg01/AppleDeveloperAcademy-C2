//
//  starView.swift
//  Stellaiary
//
//  Created by POS on 4/18/25.
//
// 괴랄하다 괴랄해... scenePhase, PersistentIdentifier ...

import SwiftData
import SwiftUI

struct starView: View {
    @Query private var dats: [Dats]
    @Query private var cats: [Cats]
    @Environment(\.scenePhase) private var scenePhase

    @State private var starPositions: [PersistentIdentifier: CGPoint] = [:]
    @State private var didRegen = false  // reposition when entering foreground
    @State private var starScales: [PersistentIdentifier: CGFloat] = [:]
    
    private let colors: [Color] = [ // 7개가 max
        .c1,
        .c2,
        .c3,
        .c4,
        .c5,
        .c6,
        .c7,
        
    ]
    private let colorNames: [String] = [
        "c1",
        "c2",
        "c3",
        "c4",
        "c5",
        "c6",
        "c7",
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // max 30 contents
                ForEach(
                    Array(dats.filter { !$0.isDel }.prefix(30)),
                    id: \.id  // PersistentIdentifier ...가 뭔데ㅠㅜㅠ
                ) { dat in
                    let color = colorForCategory(dat.category)
                    let position =
                        starPositions[dat.id]
                        ?? randomPosition(in: geometry.size)
                    let scale = starScales[dat.id] ?? 1.0

                    Button(action: { //blinking animation
                        withAnimation(.easeInOut(duration: 0.3)) {
                            starScales[dat.id] = 2.7
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                starScales[dat.id] = 1.0
                            }
                        }
                    }) {
                        starr()
                            .fill(color)
                            .frame(width: 22) // star size
                            .opacity(dat.level)
                            .scaleEffect(scale)
                    }
                    .position(position)
                    .onAppear {
                        // first appearing data
                        if starPositions[dat.id] == nil {
                            starPositions[dat.id] = randomPosition(
                                in: geometry.size
                            )
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    if !didRegen {
                        regenerateAllPositions(in: geometry.size)
                        didRegen = true
                    }
                } else {
                    // init flag when app is at background
                    didRegen = false
                }
            }
        }
    }

    private func colorForCategory(_ categoryName: String) -> Color {
        guard let cat = cats.first(where: { $0.name == categoryName }) else {
            print("Error: unknown category '\(categoryName)'")
            return .gray
        }

        let key =
            cat.color.hasPrefix(".") ? String(cat.color.dropFirst()) : cat.color
        if let idx = colorNames.firstIndex(of: key) {
            return colors[idx]
        } else {
            print("Error: color undefined for \(categoryName)")
            return .gray
        }
    }

    func randomPosition(in size: CGSize) -> CGPoint {
        let padding: CGFloat = 60
        let minY: CGFloat = 0 // from top of screen
        let maxY = size.height * 0.8  // to nn% screen coverage
        let x = CGFloat.random(in: padding...(size.width - padding))
        let y = CGFloat.random(in: minY...(maxY - padding))
        return CGPoint(x: x, y: y)
    }
    

    func regenerateAllPositions(in size: CGSize) {
        for dat in dats.filter({ !$0.isDel }) {
            starPositions[dat.id] = randomPosition(in: size)
        }
    }
}

#Preview {
    starView()
        .modelContainer(for: [Dats.self, Cats.self])
}

//
//  starView.swift
//  Stellaiary
//
//  Created by POS on 4/18/25.
//

//import SwiftUI
//import SwiftData
//
//struct starView: View {
//    @Query private var dats: [Dats]
//    @Query private var cats: [Cats]
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack {
//                ForEach(Array(dats.filter { !$0.isDel }.prefix(30).enumerated()), id: \.offset) { index, dat in
//                    let color = colorForCategory(dat.category)
//                    let position = randomPosition(in: geometry.size)
//
//                    Button(action: {
//                        print("Tapped on: \(dat.title)")
//                    }) {
//                        starr()
//                            .frame(width: 30)
//                            .foregroundColor(color)
//                    }
//                    .position(position)
//                }
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
//        }
//    }
//
//    func colorForCategory(_ categoryName: String) -> Color {
//        if let cat = cats.first(where: { $0.name == categoryName }) {
//            return Color(named: cat.color)
//        }
//        return .gray
//    }
//
//    func randomPosition(in size: CGSize) -> CGPoint {
//        let padding: CGFloat = 40
//        let x = CGFloat.random(in: padding...(size.width - padding))
//        let y = CGFloat.random(in: padding...(size.height - padding))
//        return CGPoint(x: x, y: y)
//    }
//}
//
//extension Color {
//    init(named name: String) {
//        switch name {
//        case "picBlue": self = .picBlue
//        case "picSkyblue": self = .picSkyblue
//        case "picPink": self = .picPink
//        
//        default: self = .gray
//        }
//    }
//}

import SwiftUI
import SwiftData

/// A “star” view showing up to 30 cross‑star buttons at random positions
struct starView: View {
    @Query private var dats: [Dats]
    @Query private var cats: [Cats]

    // Predefined palette matching colorPicker
    private let colorPalette: [Color] = [
        .picSkyblue,
        .picBlue,
        .picPink,
        .picRed,
        .picOrange,
        .picYellow,
        .picGreen
    ]
    private let colorNames: [String] = [
        "picSkyblue",
        "picBlue",
        "picPink",
        "picRed",
        "picOrange",
        "picYellow",
        "picGreen"
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // max 30 contents
                ForEach(Array(dats.filter { !$0.isDel }.prefix(30).enumerated()), id: \ .offset) { index, dat in
                    let color = colorForCategory(dat.category)
                    let position = randomPosition(in: geometry.size)

                    Button(action: {
                        print("Tapped on: \(dat.title)")
                    }) {
                        starr()
                            .fill(color.opacity(Double(dat.level)))
                            .frame(width: 27)
                    }
                    .position(position)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func colorForCategory(_ categoryName: String) -> Color {
        guard let cat = cats.first(where: { $0.name == categoryName }) else {
            print("Error: unknown category '\(categoryName)'")
            return .gray
        }
        
        // formatting into Color type
        let key = cat.color.hasPrefix(".") ? String(cat.color.dropFirst()) : cat.color
        if let idx = colorNames.firstIndex(of: key) {
            return colorPalette[idx]
        }else {
            print("Error: color undefined for \(categoryName)")
            return .gray
        }
    }

    func randomPosition(in size: CGSize) -> CGPoint {
            let padding: CGFloat = 40
            let x = CGFloat.random(in: padding...(size.width - padding))
            let y = CGFloat.random(in: padding...(size.height - padding))
            return CGPoint(x: x, y: y)
        }
}




#Preview {
    starView()
        .modelContainer(for: [Dats.self, Cats.self])
}

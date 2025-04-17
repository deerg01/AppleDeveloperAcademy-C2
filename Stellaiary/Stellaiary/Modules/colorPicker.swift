//
//  colorPicker.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftUI

struct colorPicker: View {
    @Binding var selectedColor: String

    let colors: [Color] = [
        .picSkyblue,
        .picBlue,
        .purple,
        .picPink,
        .picRed,
        .picSalmon,
        .picOrange,
        .picYellow,
        .picOlive,
        .picGreen,
    ]

    let colorNames: [String] = [
        "picSkyblue",
        "picBlue",
        "purple",
        "picPink",
        "picRed",
        "picSalmon",
        "picOrange",
        "picYellow",
        "picOlive",
        "picGreen",
    ]

    var body: some View {
        Grid {
            GridRow {
                ForEach(0..<colors.count, id: \.self) { index in
                    Button {
                        selectedColor = colorNames[index]
                    } label: {
                        Rectangle()
                            .fill(colors[index])
                            .frame(width: 35, height: 35)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(
                                        selectedColor == colorNames[index]
                                        ? Color.white
                                        : colors[index],
                                        lineWidth: 3
                                    )
                            )
                    }
                }
            }
            .padding(-2.5)
        }
    }
}

#Preview {
    @State var color = "picPink"

    return colorPicker(selectedColor: $color)
}

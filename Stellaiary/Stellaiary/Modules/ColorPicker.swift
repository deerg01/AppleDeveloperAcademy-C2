//
//  colorPicker.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftUI

struct colorPicker: View {
    @Binding var selectedColor: String

    let colors: [Color] = [ // 7개가 max
        .c1,
        .c2,
        .c3,
        .c4,
        .c5,
        .c6,
        .c7,
        
    ]

    let colorNames: [String] = [
        "c1",
        "c2",
        "c3",
        "c4",
        "c5",
        "c6",
        "c7",
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
                            .frame(width: 41, height: 41)
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
    @State var color = "c4"

    return colorPicker(selectedColor: $color)
}

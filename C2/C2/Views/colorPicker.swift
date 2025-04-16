//
//  colorPicker.swift
//  C2
//
//  Created by POS on 4/16/25.
//

import SwiftUI

struct ColPicker: View {
    
    //var sel: String // selected color. 나중에 Cats에서 값 땡겨와야ㅁ
    
    var body: some View {
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
            .picGreen
        
        ]
        
//        let colors = [
//            "picSkyblue",
//            "picBlue",
//            "purple",
//            "picPink",
//            "picRed",
//            "picSalmon",
//            "picOrange",
//            "picYellow",
//            "picOlive",
//            "picGreen"
//            
//        ]
        
        

//        let columns = [
//            GridItem(.adaptive(minimum: 44))
//        ]
//
//        LazyVGrid(columns: columns) {
//            ForEach(colors, id: \.self) { color in
//                Button {
//                    // Cats의 color값에 assign되도록
//                } label: {
//                    Rectangle()
//                        .fill(Color(color))
//                        .frame(width: 44, height: 44)
//                        .padding(-4)
//                }
//            }
//        }
//        .padding()

        Grid {
            GridRow {
                ForEach(colors, id: \.self) { color in
                    Button {
                        //sel = color
                        // Cats의 color값에 assign되도록
                    } label: {
                        Rectangle()
                            .fill(Color(color))
                            .frame(width: 40, height: 40)
                    }
                    
//                    if sel == color { //selected button은 inner stroke
//
//                    }

                }
            }
            .padding(-5)
        }
    }
}

#Preview {
    ColPicker()
}

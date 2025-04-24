//
//  ContentView.swift
//  ddddd
//
//  Created by POS on 4/24/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {

        TabView {
            ZStack {
                EllipticalGradient(
                    stops: [
                        Gradient.Stop(
                            color: Color(red: 0.1, green: 0.39, blue: 0.71),
                            location: 0.00
                        ),
                        Gradient.Stop(
                            color: Color(red: 0.01, green: 0.18, blue: 0.59),
                            location: 0.33
                        ),
                        Gradient.Stop(
                            color: Color(red: 0.07, green: 0.03, blue: 0.28),
                            location: 0.71
                        ),
                    ],
                    center: UnitPoint(x: 0.63, y: 0.35)
                )
                
                .ignoresSafeArea()

                RoundedRectangle(cornerRadius: 11)
                    .inset(by: 0.5)
                    .stroke(
                        Color(red: 0.31, green: 0.29, blue: 0.45),
                        lineWidth: 1
                    )
                    .fill(
                        LinearGradient(
                            stops: [
                                Gradient.Stop(
                                    color: Color(
                                        red: 0.78,
                                        green: 0.78,
                                        blue: 0.8
                                    ),
                                    location: 0.00
                                ),
                                Gradient.Stop(
                                    color: Color(
                                        red: 0.62,
                                        green: 0.6,
                                        blue: 0.67
                                    ),
                                    location: 1.00
                                ),
                            ],
                            startPoint: UnitPoint(x: 0.04, y: 0.02),
                            endPoint: UnitPoint(x: 0.66, y: 0.5)
                        )
                    )
                    .frame(maxWidth: 353, maxHeight: 300)
            

//                starView()
                    
            }
            
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}

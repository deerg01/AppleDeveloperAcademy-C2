//
//  splashView.swift
//  Stellaiary
//
//  Created by POS on 4/28/25.
//
// 짚핕팅야 고마워ㅓ ~.~

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            EllipticalGradient(
                stops: [
                    Gradient.Stop(
                        color: Color(red: 0.1, green: 0.39, blue: 0.71),
                        location: 0.00
                    ),
                    Gradient.Stop(
                        color: Color(red: 0.01, green: 0.18, blue: 0.59),
                        location: 0.35
                    ),
                    Gradient.Stop(
                        color: Color(red: 0.07, green: 0.03, blue: 0.28),
                        location: 0.73
                    ),
                ],
                center: UnitPoint(x: 1.19, y: 1.13)
            )
            .ignoresSafeArea()

            if isActive {
                ContentView()
            } else {
                VStack {
                    Text("Stellaiary")
                        .font(.custom("Ubuntu", size: 37))
                        .foregroundColor(.white)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

struct spView: View {
    var body: some View {
        ZStack {
            EllipticalGradient(
                stops: [
                    Gradient.Stop(
                        color: Color(red: 0.1, green: 0.39, blue: 0.71),
                        location: 0.00
                    ),
                    Gradient.Stop(
                        color: Color(red: 0.01, green: 0.18, blue: 0.59),
                        location: 0.35
                    ),
                    Gradient.Stop(
                        color: Color(red: 0.07, green: 0.03, blue: 0.28),
                        location: 0.73
                    ),
                ],
                center: UnitPoint(x: 0.86, y: 1.2)
            )
            .ignoresSafeArea()
            
            Text("Stellaiary")
                .font(.custom("Ubuntu", size: 37))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    spView()
}

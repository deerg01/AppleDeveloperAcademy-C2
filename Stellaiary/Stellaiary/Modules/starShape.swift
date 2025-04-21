//
//  starShape.swift
//  Stellaiary
//
//  Created by POS on 4/18/25.
//
// 아니 왜 기본 shape에 별이 없음;;

import Foundation
import SwiftUI

struct starr: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outer = min(rect.width, rect.height) / 2

        let angles: [Double] = [-90, 0, 90, 180]

        for (i, angleDeg) in angles.enumerated() {
            let angle = Angle(degrees: angleDeg).radians

            let outerPoint = CGPoint(
                x: center.x + CGFloat(cos(angle)) * outer,
                y: center.y + CGFloat(sin(angle)) * outer * 1.7
            )

            let leftAngle = Angle(degrees: angleDeg - 45).radians
            let rightAngle = Angle(degrees: angleDeg + 45).radians
            let sideLength = outer * 0.2

            let leftPoint = CGPoint(
                x: center.x + CGFloat(cos(leftAngle)) * sideLength,
                y: center.y + CGFloat(sin(leftAngle)) * sideLength
            )

            let rightPoint = CGPoint(
                x: center.x + CGFloat(cos(rightAngle)) * sideLength,
                y: center.y + CGFloat(sin(rightAngle)) * sideLength
            )

            if i == 0 {
                path.move(to: leftPoint)
            } else {
                path.addLine(to: leftPoint)
            }

            path.addLine(to: outerPoint)
            path.addLine(to: rightPoint)
        }

        path.closeSubpath()
        return path
    }
}

struct starPreview: PreviewProvider {
    static var previews: some View {
        starr()
            .fill(Color.blue)
            .frame(width: 120)

    }
}

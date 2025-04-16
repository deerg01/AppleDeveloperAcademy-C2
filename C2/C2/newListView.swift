//
//  newListView.swift
//  C2
//
//  Created by POS on 4/10/25.
//

import SwiftUI
import SwiftData

struct newListView: View {
    @Query private var recs: [Recs]
    @State private var selectedRec: Recs? = nil
    @State private var circlePositions: [String: CGPoint] = [:]
    
    var filteredRecs: [Recs] {
        recs
    }
    
    var body: some View {
        NavigationStack {
            Text("Hello World!")
            //            GeometryReader { geometry in
            //                ZStack {
            //                    ForEach(filteredRecs, id: \.id) { rec in
            //                        let id = rec.id
            //
            //                        let position = circlePositions[id] ?? randomPosition(in: geometry.size)
            //
            //                        Circle()
            //                            .fill(Color.blue.opacity(0.7))
            //                            .frame(width: 60, height: 60)
            //                            .overlay(Text("✏️").font(.title))
            //                            .position(position)
            //                            .onTapGesture {
            //                                selectedRec = rec
            //                            }
            //                            .onAppear {
            //                                if circlePositions[id] == nil {
            //                                    circlePositions[id] = randomPosition(in: geometry.size)
            //                                }
            //                            }
            //                    }
            //                }
            //                .frame(width: geometry.size.width, height: geometry.size.height)
            //                .navigationTitle("메모들")
            //                .sheet(item: $selectedRec) { rec in
            //                    editView(rec: rec)
            //                }
            //            }
            //        }
            //    }
            //
            //    func randomPosition(in size: CGSize) -> CGPoint {
            //        let padding: CGFloat = 40
            //        let x = CGFloat.random(in: padding...(size.width - padding))
            //        let y = CGFloat.random(in: padding...(size.height - padding))
            //        return CGPoint(x: x, y: y)
        }
    }
}

//#Preview {
//    newListView()
//        .modelContainer(for: Recs.self)
//}

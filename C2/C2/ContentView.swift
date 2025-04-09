//
//  ContentView.swift
//  C2
//
//  Created by POS on 4/8/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recs: [Recs]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("우헤헤 C2 도전기록앱")
                    .bold()
                    .padding(.bottom, 28)
                NavigationLink("Write") {
                    writeView()
                }
                Divider()
                
                NavigationLink("List") {
                    ListView()
                }
            }
            .padding()
            
            NavigationLink("모든 메모") {
                allRecsView()
            }
            .padding(.top, 50)
            .foregroundColor(.pink)
            
            NavigationLink("휴지통") {
                delView()
            }
            .padding(.top, 7)
            .foregroundColor(.pink)
            

            
        }
        .onAppear {
                    insertInitialDataIfNeeded()
                }
    }
    
    func insertInitialDataIfNeeded() {
            guard recs.isEmpty else { return }

            let samples: [Recs] = [
                Recs(category: Cats.aa.rawValue, title: "아침 6시에 일어나기", content: "알람듣고 기깔나게 일어나기"),
                Recs(category: Cats.ab.rawValue, title: "드로잉 연습 30분", content: "단 Figma만 이용하기"),
                Recs(category: Cats.ac.rawValue, title: "물 2L 마시기", content: "와구와구"),
            ]
            samples.forEach { modelContext.insert($0) }

            //print("system: seed data inserted")
        }
}

#Preview {
    ContentView()
        .modelContainer(for: Recs.self)
}

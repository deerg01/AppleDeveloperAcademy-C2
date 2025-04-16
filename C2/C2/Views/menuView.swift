//
//  menuView.swift
//  C2
//
//  Created by POS on 4/12/25.
//


import SwiftData
import SwiftUI

struct menuView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var recs: [Recs]

    @State private var navToStar = false  // navigatie to starView
    @GestureState private var dragOffset: CGSize = .zero

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(  // background
                    stops: [
                        Gradient.Stop(
                            color: Color(red: 0.14, green: 0.11, blue: 0.3),
                            location: 0.00
                        ),
                        Gradient.Stop(
                            color: Color(red: 0, green: 0.45, blue: 1),
                            location: 1.00
                        ),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0.37),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
                .ignoresSafeArea()

                controlView()  // menu control in rectangle area

                //                RoundedRectangle(cornerRadius: 25, style: .continuous)
                //                    .fill(.ultraThinMaterial)
                //                    .frame(height: 300)
                //                    .overlay(
                //                        controlView()
                //                    )
                //
                //                    .padding(.horizontal, 24)
                //                    .shadow(radius: 10)
                //                    .offset(x: dragOffset.width)

            }

            //                            VStack {
            //                                Spacer()
            //
            //                                RoundedRectangle(cornerRadius: 25, style: .continuous)
            //                                    .fill(.ultraThinMaterial)
            //                                    .frame(height: 300)
            //                                    .overlay(
            //                                        NavigationStack{
            //                                            VStack(spacing: 16) {
            //                                                NavigationLink(destination: writeView()) {
            //                                                    HStack {
            //                                                        Text("새 도전 작성하기")
            //                                                        Spacer()
            //                                                        Image(systemName: "chevron.right")
            //                                                    }
            //                                                    .foregroundColor(.white)
            //                                                }
            //                                                Divider()
            //
            //                                                NavigationLink(destination: listView()) {
            //                                                    HStack {
            //                                                        Text("도전 기록 보기")
            //                                                        Spacer()
            //                                                        Image(systemName: "chevron.right")
            //                                                    }
            //                                                    .foregroundColor(.white)
            //                                                }
            //                                                Divider()
            //
            //                                                NavigationLink(destination: delView()) {
            //                                                    HStack {
            //                                                        Text("쓰레기통")
            //                                                        Spacer()
            //                                                        Image(systemName: "chevron.right")
            //                                                    }
            //                                                    .foregroundColor(.white)
            //                                                }
            //                                            }
            //                                            .padding(.horizontal)
            //                                            .padding(.horizontal, 30)
            //                                            .padding(.vertical, 20)
            //                                        }
            //                                    )
            //                                    .padding(.horizontal, 24)
            //                                    .shadow(radius: 10)
            //                                    .offset(x: dragOffset.width)
            //                                                        Spacer()
            //                                    .navigationDestination(isPresented: $navToStar) {
            //                                        starView()
            //                                            .transition(.move(edge: .trailing))
            //                                    }
            //                            }
            //                        }
            //                        .gesture( // navigate to starView on Drag
            //                            DragGesture()
            //                                .updating($dragOffset) { value, state, _ in
            //                                    if value.translation.width < -10 { // right to left swipe
            //                                        state = value.translation
            //                                    }
            //                                }
            //                                .onEnded { value in
            //                                    if value.translation.width < -70 {
            //                                        withAnimation(.easeInOut) {
            //                                            navToStar = true
            //                                        }
            //                                    }
            //                                }
            //                        )
        }
        .onAppear {
            insertInitialDataIfNeeded()
        }
    }

    func insertInitialDataIfNeeded() {
        guard recs.isEmpty else { return }

        let samples: [Recs] = [
            Recs(
                category: Cats.aa.rawValue,
                title: "아침 6시에 일어나기",
                content: "알람듣고 기깔나게 일어나기"
            ),
            Recs(
                category: Cats.ab.rawValue,
                title: "드로잉 연습 30분",
                content: "단 Figma만 이용하기"
            ),
            Recs(
                category: Cats.ac.rawValue,
                title: "물 2L 마시기",
                content: "와구와구"
            ),
        ]
        samples.forEach { modelContext.insert($0) }

        //print("system: seed data inserted")
    }
}

#Preview {
    menuView()
        .modelContainer(for: Recs.self)
}

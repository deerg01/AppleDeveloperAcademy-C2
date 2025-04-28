//
//  datListView.swift
//  Stellaiary
//
//  Created by POS on 4/17/25.
//

import SwiftUI

struct datListView: View {
    @Environment(\.modelContext) private var modelContext

    let category: String
    let dats: [Dats]

    @State private var isEditing = false
    @State private var datToDelete: Dats? = nil
    @State private var selectedDat: Dats? = nil
    @State private var toEdit = false

    var body: some View {
        ZStack {
            List {
                ForEach(dats.filter { !$0.isDel }) { dat in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(dat.title)
                                .font(.custom("IMHyemin-Bold", size: 17))
                            Text(
                                dat.date.formatted(
                                    date: .abbreviated,
                                    time: .omitted
                                )
                            )
                            .font(.custom("IMHyemin-Regular", size: 15))
                            .foregroundColor(
                                Color(red: 0.24, green: 0.24, blue: 0.24)
                            )
                        }

                        Spacer()

                        if isEditing {
                            Button {
                                datToDelete = dat
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(Color.sysRed)
                            }
                            .buttonStyle(.borderless)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if !isEditing {
                            selectedDat = dat
                            toEdit = true
                        }
                    }
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .background(gradientBackground)  // gradient background
        }
        .alert(item: $datToDelete) { dat in
            Alert(
                title: Text("삭제하시겠습니까?"),
                primaryButton: .destructive(Text("삭제")) {
                    if let index = dats.firstIndex(where: { $0 === dat }) {
                        dats[index].isDel = true
                    }
                },
                secondaryButton: .cancel {
                    datToDelete = nil
                }
            )
        }
        .background(
            EmptyView()
                .navigationDestination(isPresented: $toEdit) {
                    if let dat = selectedDat {
                        editView(dat: dat)
                    }
                }
        )
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    isEditing.toggle()
                }) {
                    Text(isEditing ? "완료" : "편집")
                        .bold()
                }
            }
        }
        .onAppear {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()

            // 네비게이션 타이틀 폰트 변경
            navBarAppearance.titleTextAttributes = [
                .font: UIFont(name: "IMHyemin-Bold", size: 20)
                    ?? UIFont.systemFont(ofSize: 20),
                .foregroundColor: UIColor.black,
            ]

            let backButtonAppearance = UIBarButtonItemAppearance()
            backButtonAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.clear
            ]
            backButtonAppearance.normal.titlePositionAdjustment = UIOffset(
                horizontal: -1000,
                vertical: 0
            )
            navBarAppearance.backButtonAppearance = backButtonAppearance

            // 네비게이션 바 스타일 설정
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        .introspect(.viewController, on: .iOS(.v16, .v17)) { viewController in
            viewController.view.backgroundColor = .clear
        }
        .navigationBarBackButtonHidden(false)
    }

    private var gradientBackground: LinearGradient {
        LinearGradient(
            stops: [
                Gradient.Stop(
                    color: Color(red: 0.78, green: 0.78, blue: 0.8),
                    location: 0.00
                ),
                Gradient.Stop(
                    color: Color(red: 0.62, green: 0.6, blue: 0.67),
                    location: 1.00
                ),
            ],
            startPoint: UnitPoint(x: 0.04, y: 0.02),
            endPoint: UnitPoint(x: 0.66, y: 0.5)
        )
    }
}

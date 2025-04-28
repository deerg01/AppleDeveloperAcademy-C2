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
                            Text(dat.date.formatted(date: .abbreviated, time: .omitted))
                                .font(.custom("IMHyemin-Regular", size: 15))
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        if isEditing {
                            Button {
                                datToDelete = dat
                            } label: {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
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
            .background(gradientBackground) // gradient background
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
            NavigationLink(
                destination: selectedDat.map { editView(dat: $0) },
                isActive: $toEdit,
                label: { EmptyView() }
            )
            .hidden()
        )
        .navigationTitle(category)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(isEditing ? "완료" : "편집") {
                    withAnimation {
                        isEditing.toggle()
                    }
                }
            }
        }
        .onAppear {
            // 네비게이션 바 커스터마이즈
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithTransparentBackground()
//            navBarAppearance.backgroundColor = UIColor.clear // 투명 배경 설정

            // 네비게이션 타이틀 폰트 변경
            navBarAppearance.titleTextAttributes = [
                .font: UIFont(name: "IMHyemin-Bold", size: 20) ?? UIFont.systemFont(ofSize: 20),
                .foregroundColor: UIColor.black // 타이틀 글자 색상
            ]
            
            let backButtonAppearance = UIBarButtonItemAppearance()
                backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear]
                backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
                navBarAppearance.backButtonAppearance = backButtonAppearance

            // 네비게이션 바 스타일 설정
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        }
        .introspect(.viewController, on: .iOS(.v16, .v17)) { viewController in
            viewController.view.backgroundColor = .clear
        }
        .navigationBarBackButtonHidden(false) // 뒤로 가기 버튼 보이도록 설정
    }

    // gradientBackground를 별도의 변수로 분리
    private var gradientBackground: LinearGradient {
        LinearGradient(
            stops: [
                Gradient.Stop(color: .white, location: 0.00),
                Gradient.Stop(
                    color: Color(red: 0.6, green: 0.6, blue: 0.6),
                    location: 1.00
                ),
            ],
            startPoint: UnitPoint(x: 0.04, y: 0),
            endPoint: UnitPoint(x: 1, y: 1)
        )
    }
}


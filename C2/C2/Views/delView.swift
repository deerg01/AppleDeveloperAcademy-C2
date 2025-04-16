import SwiftData
import SwiftUI

struct delView: View {
    @Query private var allRecs: [Recs]
    @Environment(\.modelContext) private var modelContext

    @State private var delAlert = false
    @State private var emptAlert = false

    var body: some View {
        VStack {
            List {
                ForEach(trashedRecs) { rec in
                    VStack(alignment: .leading) {
                        Text(rec.title)
                            .font(.headline)
                        Text(rec.content) //이후 Date로 수정
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button {
                            rec.isDel = false
                        } label: {
                            Label("Undo", systemImage: "arrow.uturn.backward")
                        }
                        .tint(.blue)
                    }
                }
            }
            .alert("휴지통을 비우시겠습니까?", isPresented: $delAlert) {
                Button("삭제", role: .destructive) {
                    emptyTrash()
                }
                Button("취소", role: .cancel) {}
            } message: {
                Text("이 동작은 돌이킬 수 없습니다.")
            }
            .alert("휴지통은 비어있습니다", isPresented: $emptAlert) {
                Button("확인", role: .cancel) {}
            }
        }
        .navigationTitle("휴지통")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(role: .destructive) {
                    if trashedRecs.isEmpty {
                        emptAlert = true
                    } else {
                        delAlert = true
                    }
                } label: {
                    Text("삭제")
                        .tint(Color.sysRed)
                }
            }
        }
    }

    
    private var trashedRecs: [Recs] { // del 처리된 데이터들의 array
        allRecs.filter { $0.isDel }
    }

    private func emptyTrash() {
        for rec in trashedRecs {
            modelContext.delete(rec)
        }
        try? modelContext.save()
    }
}

#Preview {
    menuView()
        .modelContainer(for: Recs.self)
}

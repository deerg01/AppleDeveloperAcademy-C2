// delView.swift

import SwiftUI
import SwiftData

struct _delView: View {
    @Query private var allRecs: [Recs]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            List {
                ForEach(trashedRecs) { rec in
                    VStack(alignment: .leading) {
                        Text(rec.title)
                            .font(.headline)
                        Text(rec.content)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button{
                            rec.isDel = false
                        } label: {
                            Label("Undo", systemImage: "arrow.uturn.backward")
                        }
                            .tint(.blue)
                    }
                }
            }

            Button(role: .destructive) {
                emptyTrash()
            } label: {
                Text("휴지통 비우기")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding()
        }
        .navigationTitle("휴지통")
    }

    private var trashedRecs: [Recs] {
        allRecs.filter { $0.isDel }
    }

    private func emptyTrash() {
        //if trashRecs.IsEmpty()
        for rec in trashedRecs {
            modelContext.delete(rec)
        }
        try? modelContext.save()
    }
}

#Preview {
    _delView()
        .modelContainer(for: Recs.self)
}

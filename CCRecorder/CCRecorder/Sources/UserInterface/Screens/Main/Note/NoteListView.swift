//
//  NoteListView.swift
//  CCRecorder
//
//  Created by 김용우 on 9/11/24.
//

import SwiftUI
import SwiftData

struct NoteListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Note.createdDate) private var notes: [Note]
    
    private var sortedNotes: [Note] { notes.sorted { !($0.isDone && !$1.isDone) } }
    
    var body: some View {
        NoteList(
            notes: .init(get: { sortedNotes }, set: { _ in }),
            onDelete: onDelete(at:)
        )
        .navigationTitle("Note")
        /// FIXME: 더미 데이터 - 시작
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button(
                    action: {
                        modelContext.insert(
                            Note(
                                original: "Dummy",
                                translation: "",
                                category: [
                                    Note.Category.sentence,
                                    Note.Category.vocabulary
                                ][Int.random(in: 0...1)]
                            )
                        )
                    }, label: { Text("더미 추가") }
                )
            }
        }
        /// FIXME: 더미 데이터 - 끝
    }
    
}

private extension NoteListView {
    
    func onDelete(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(sortedNotes[offset])
        }
    }
    
}

#Preview {
    NoteListView()
}

//
//  NoteList.swift
//  CCRecorder
//
//  Created by 김용우 on 9/9/24.
//

import SwiftUI
import SwiftData

struct NoteList: View {
    @Environment(ViewCoordinator.self) private var viewCoordinator
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Note.createdDate) private var notes: [Note]
    
    @State private var isPresentedModal: Note?

    var body: some View {
        List {
            ForEach(sortedNotes, id: \.id) { note in
                NoteListRow(note: note)
                    .onTapGesture {
                        isPresentedModal = note
                    }
            }
            .onDelete(perform: onDelete(at:))
        }
        .listStyle(.plain)
        .navigationTitle("Note")
        .sheet(item: $isPresentedModal) { note in
            NoteDetail(note: note)
                .presentationDetents(detents(of: note.category))
        }
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

private extension NoteList {
    
    var sortedNotes: [Note] {
        notes.sorted {
            if $0.isDone != $1.isDone {
                !$0.isDone && $1.isDone         /// isDone이 false인 항목이 먼저
            } else {
                $0.createdDate < $1.createdDate /// isDone이 같으면 createdDate로 정렬
            }
        }
    }
    
    func detents(of category: Note.Category) -> Set<PresentationDetent> {
        switch category {
            case .vocabulary:   [.medium]
            case .sentence:     [.medium, .large]
        }
    }
    func onDelete(at offsets: IndexSet) {
        for offset in offsets {
            modelContext.delete(notes[offset])
        }
    }
    
}

#Preview {
    NoteList()
        .environment(ViewCoordinator())
}

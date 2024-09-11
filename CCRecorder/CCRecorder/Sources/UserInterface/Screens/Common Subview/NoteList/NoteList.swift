//
//  NoteList.swift
//  CCRecorder
//
//  Created by 김용우 on 9/9/24.
//

import SwiftUI

struct NoteList: View {
    @Binding var notes: [Note]
    
    let onDelete: (IndexSet) -> Void
    
    @State private var isPresentedModal: Note?

    var body: some View {
        List {
            ForEach(notes, id: \.id) { note in
                NoteListRow(note: note)
                    .onTapGesture {
                        isPresentedModal = note
                    }
            }
            .onDelete(perform: onDelete)
        }
        .listStyle(.plain)
        .sheet(item: $isPresentedModal) { note in
            NoteDetail(note: note)
                .presentationDetents(detents(of: note.category))
        }
        /// FIXME: 더미 데이터 - 시작
        .toolbar {
            ToolbarItem(placement: .principal) {
                Button(
                    action: {
                        notes.append(
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
    
    func detents(of category: Note.Category) -> Set<PresentationDetent> {
        switch category {
            case .vocabulary:   [.medium]
            case .sentence:     [.medium, .large]
        }
    }
    
}

#Preview {
    NoteList(
        notes: .constant([.sentenceDummy, .vocabularyDummy]),
        onDelete: { _ in }
    )
}

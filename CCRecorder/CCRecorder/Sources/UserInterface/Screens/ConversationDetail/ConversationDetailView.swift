//
//  ConversationDetail.swift
//  CCRecorder
//
//  Created by 김용우 on 9/9/24.
//

import SwiftUI
import SwiftData

struct ConversationDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Conversation.createdDate) private var conversations: [Conversation]

    @State var conversation: Conversation
    
    var body: some View {
        VStack {
            Color.gray
                .overlay {
                    Text("CoversationDetail")
                }
            NoteList(
                notes: $conversation.notes,
                onDelete: onDelete(of:)
            )
            PlayTab()
        }
    }
    
}

private extension ConversationDetailView {
    
    func onDelete(of indexSet: IndexSet) {
        conversation.notes.remove(atOffsets: indexSet)
    }
    
}

#if DEBUG
#Preview {
    ConversationDetailView(conversation: .preview)
}

extension Conversation {
    
    static var preview: Self {
        .init(
            recordFilePath: .init(string: "")!,
            title: "제목",
            topic: "주제",
            members: (0...3).map { .init(name: "name \($0)") }
        )
    }
    
}
#endif

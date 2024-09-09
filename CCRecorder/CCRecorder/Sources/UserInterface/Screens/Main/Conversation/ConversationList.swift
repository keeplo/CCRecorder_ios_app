//
//  ConversationList.swift
//  CCRecorder
//
//  Created by 김용우 on 9/9/24.
//

import SwiftUI

struct ConversationList: View {
    @Environment(ViewCoordinator.self) private var viewCoordinator

    var body: some View {
        VStack {
            Spacer()
            Button(
                action: { viewCoordinator.push(.setting) },
                label: { Text("설정 화면 이동") }
            )
            Spacer()
        }
        .navigationTitle("Conversation")
    }
}

#Preview {
    ConversationList()
        .environment(ViewCoordinator())
}

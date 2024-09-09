//
//  MainView.swift
//  CCRecorder
//
//  Created by 김용우 on 9/6/24.
//

import SwiftUI

enum Tab {
    case conversationList
    case noteList
}

struct MainView: View {
    @Environment(ViewCoordinator.self) private var viewCoordinator
    
    @State private var selectedTab: Tab = .conversationList
    @State private var isPresentedModal: Bool = false

    var body: some View {
        VStack {
            switch selectedTab {
                case .conversationList:
                    ConversationList()
                case .noteList:
                    NoteList()
            }
            Spacer() // TODO: 메인 화면 구성
            MainTabbar(selectedTab: $selectedTab)
        }
        .sheet(isPresented: $isPresentedModal) {
            RecordView()
        }
    }
    
}

#Preview {
    MainView()
        .environment(ViewCoordinator())
}

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
                case .conversationList:     ConversationList()
                case .noteList:             NoteList()
            }
            MainTabbar(
                selectedTab: $selectedTab, 
                isPresentedModal: $isPresentedModal
            )
        }
        .fullScreenCover(isPresented: $isPresentedModal) {
            RecordView()
        }
        .toolbar {
            MainViewToolbar()
        }
    }
    
}

fileprivate struct MainViewToolbar: ToolbarContent {
    @Environment(ViewCoordinator.self) private var viewCoordinator
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(
                action: { viewCoordinator.push(.setting) },
                label: { 
                    Image(systemName: "gear")
                        .tint(.accent)
                }
            )
        }
    }
    
}


#Preview {
    MainView()
        .environment(ViewCoordinator())
}

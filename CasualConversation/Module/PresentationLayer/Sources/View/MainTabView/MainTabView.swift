//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

enum Tab {
    case conversations
    case notes
}

struct MainTabView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	
    @State private var selectedTab: Tab = .conversations
    @State private var isPresentedRecordView: Bool = false
    
    private var navigationTitle: String {
        switch selectedTab {
            case .conversations:    return "Conversations"
            case .notes:            return "Notes"
        }
    }
	
	var body: some View {
		NavigationView {
            content
				.navigationBarTitleDisplayMode(.large)
                .fullScreenCover(isPresented: $isPresentedRecordView) {
					container.recordView()
				}
		}
    }
    
    var content: some View {
        ZStack {
            switch selectedTab {
                case .conversations:        container.ConversationListView()
                case .notes:                container.NoteSetView()
            }
        }
        .overlay {
            MainTab(
                selectedTab: $selectedTab,
                isPresentedRecordView: $isPresentedRecordView)
        }
        .background(Color.ccBgColor)
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: container.SettingView()) {
                    Image(systemName: "gear")
                }
            }
        }
    }

}

#if DEBUG
#Preview {
    MainTabView(viewModel: .preview)
        .preferredColorScheme(.light)
}

#Preview {
    MainTabView(viewModel: .preview)
        .preferredColorScheme(.dark)
}
#endif

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
	
	@EnvironmentObject private var viewMaker: ViewMaker
	
    @State private var selectedTab: Tab = .conversations
    @State private var isPresentedRecordView: Bool = false
    @State private var isPresentedTutorial: Bool = !Preference.shared.isDoneTutorial
    
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
                    viewMaker.makeView(.record)
				}
                .fullScreenCover(isPresented: $isPresentedTutorial) {
                    TutorialView()
                }
		}
    }
    
    var content: some View {
        ZStack {
            switch selectedTab {
                case .conversations:        viewMaker.makeView(.conversationList)
                case .notes:                viewMaker.makeView(.noteSet(nil))
            }
        }
        .overlay {
            MainTab(
                selectedTab: $selectedTab,
                isPresentedRecordView: $isPresentedRecordView
            )
        }
        .background(Color.ccBgColor)
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: viewMaker.makeView(.setting)) {
                    Image(systemName: "gear")
                }
            }
        }
    }

}

#if DEBUG
#Preview {
    MainTabView()
        .preferredColorScheme(.light)
}

#Preview {
    MainTabView()
        .preferredColorScheme(.dark)
}
#endif

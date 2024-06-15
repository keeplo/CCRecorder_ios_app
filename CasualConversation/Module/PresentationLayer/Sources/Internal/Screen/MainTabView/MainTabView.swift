//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct MainTabView: View {
	
    // MARK: - Dependency
	@EnvironmentObject private var viewMaker: ViewMaker
	
    // MARK: - View Render
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
        .toolbar(
            MainViewToolBar(
                destination: viewMaker.makeView(.setting)
            )
        )
    }
    
    // MARK: - View Action
    @State private var selectedTab: Tab = .conversations
    @State private var isPresentedRecordView: Bool = false
    @State private var isPresentedTutorial: Bool = !Preference.shared.isDoneTutorial
    
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

    // MARK: - Private Methods
    private var navigationTitle: String {
        switch selectedTab {
            case .conversations:    return "Conversations"
            case .notes:            return "Notes"
        }
    }
    
}

// MARK: - Preview
#Preview("라이트 모드") {
    MainTabView()
        .preferredColorScheme(.light)
}

#Preview("다크 모드") {
    MainTabView()
        .preferredColorScheme(.dark)
}

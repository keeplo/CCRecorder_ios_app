//
//  MainTabViewModel.swift
//  Presentation
//
//  Created by Yongwoo Marco on 2022/08/14.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import SwiftUI

final class MainTabViewModel: ObservableObject {
    enum Tab {
        case conversations, notes
    }
    
    @Published var selectedTab: Tab = .conversations
    @Published var isPresentedRecordView: Bool = false
    
}

// MARK: - View Configure
extension MainTabViewModel {
	
    var title: String {
        switch selectedTab {
            case .conversations:    return "Conversations"
            case .notes:            return "Notes"
        }
    }
	
    var tabItemImageName: String {
		switch selectedTab {
		case .conversations: 	return "rectangle.stack.badge.play.fill"
		case .notes:			return "checklist"
		}
	}
	
    func currentTintColor(from tab: Tab) -> Color {
		let tintColor: (light: Color, dark: Color)
        switch tab {
        case .conversations:     tintColor = (Color.logoLightRed, Color.logoDarkRed)
        case .notes:             tintColor = (Color.logoLightBlue, Color.logoDarkBlue)
        }
		return tab == selectedTab ? tintColor.light : tintColor.dark
	}
	
}

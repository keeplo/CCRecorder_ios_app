//
//  CCTabItem.swift
//  CCRecorderApp
//
//  Created by 김용우 on 3/24/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import SwiftUI

struct MainTab: View {
    @Binding var selectedTab: Tab
    @Binding var isPresentedRecordView: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                CCTabItem(
                    tab: .conversations,
                    selectedTab: $selectedTab
                )
                Button(
                    action: { isPresentedRecordView.toggle() },
                    label: {
                        Spacer()
                        ZStack(alignment: .center) {
                            Circle()
                                .fill(Color.ccTintColor)
                                .frame(height: 74)
                            Image(systemName: "mic.fill.badge.plus")
                                .font(.system(size: 44))
                                .foregroundColor(.white)
                        }
                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                        Spacer()
                    }
                )
                CCTabItem(
                    tab: .notes,
                    selectedTab: $selectedTab
                )
            }
            .padding()
            .background(Color.ccGroupBgColor)
        }
    }
    
}

fileprivate struct CCTabItem: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    
    private var tabItemImageName: String {
        switch tab {
        case .conversations:     return "rectangle.stack.badge.play.fill"
        case .notes:            return "checklist"
        }
    }
    
    private func currentTintColor(from tab: Tab) -> Color {
        let tintColor: (light: Color, dark: Color)
        switch tab {
        case .conversations:     tintColor = (Color.logoLightRed, Color.logoDarkRed)
        case .notes:             tintColor = (Color.logoLightBlue, Color.logoDarkBlue)
        }
        return tab == selectedTab ? tintColor.light : tintColor.dark
    }
    
    var body: some View {
        Button(
            action: { selectedTab = tab },
            label: {
                Spacer()
                Image(systemName: tabItemImageName)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(currentTintColor(from: tab))
                Spacer()
            }
        )
    }
    
}

#if DEBUg
#Preview {
    CCTabItem(selectedTab: .constant(.conversations), tab: .conversations)
}

#Preview {
    CCTabItem(selectedTab: .constant(.notes), tab: .notes)
}
#endif

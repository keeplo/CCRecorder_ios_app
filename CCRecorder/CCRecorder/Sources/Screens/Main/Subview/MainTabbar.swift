//
//  MainTabbar.swift
//  CCRecorder
//
//  Created by 김용우 on 9/9/24.
//

import SwiftUI

struct MainTabbar: View {
    @Environment(\.colorScheme) private var colorScheme
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            Spacer()
            MainTabItem(
                tab: .conversationList,
                selectedTab: $selectedTab
            )
            Spacer()
            Button(
                action: {
                    // TODO: Modal 화면
                },
                label: {
                    Spacer()
                    ZStack(alignment: .center) {
                        Image(systemName: "mic.fill.badge.plus")
                            .font(.system(size: 44))
                            .foregroundColor(.white)
                            .padding()
                            .background(recordButtonColor)
                            .clipShape(.circle)
                    }
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                    Spacer()
                }
            )
            Spacer()
            MainTabItem(
                tab: .noteList,
                selectedTab: $selectedTab
            )
            Spacer()
        }
        .padding(.vertical)
        .background(backgroundColor)
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .Dark.groupBackground : .Light.groupBackground
        
    }
    
    private var recordButtonColor: Color {
        colorScheme == .dark ? .Dark.logoGreen : .Light.logoGreen
    }
    
}

fileprivate struct MainTabItem: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button(
            action: { selectedTab = tab },
            label: {
                Spacer()
                Image(systemName: tabItemImageName)
                    .font(.system(size: 28, weight: .bold))
                    .tint(
                        currentTintColor
                    )
                Spacer()
            }
        )
    }
    
    private var tabItemImageName: String {
        switch tab {
            case .conversationList:     "rectangle.stack.badge.play.fill"
            case .noteList:             "checklist"
        }
    }
    
    private var isSelected: Bool { tab == selectedTab }
    
    private var currentTintColor: Color {
        switch tab {
            case .conversationList:     isSelected ? .Light.logoGreen : .Dark.logoGreen
            case .noteList:             isSelected ? .Light.logoRed : .Dark.logoRed
        }
    }
    
}

#Preview("대화 탭") {
    MainTabbar(selectedTab: .constant(.conversationList))
}

#Preview("노트 탭") {
    MainTabbar(selectedTab: .constant(.noteList))
}

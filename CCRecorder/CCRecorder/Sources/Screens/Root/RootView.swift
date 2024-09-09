//
//  RootView.swift
//  CCRecorder
//
//  Created by 김용우 on 9/6/24.
//

import SwiftUI

struct RootView: View {
    @State private var viewCoordinator: ViewCoordinator = .init()
    
    var body: some View {
        NavigationStack(path: $viewCoordinator.path) {
            MainView()
                .navigationDestination(for: Screen.self) {
                    switch $0 {
                        case .setting:
                            SettingView()
                    }
                }
        }
        .environment(viewCoordinator)
    }
    
}

// FIXME: 예시를 위한 구현
struct SettingView: View {
    @Environment(ViewCoordinator.self) private var viewCoordinator
    
    var body: some View {
        Button(
            action: { viewCoordinator.pop() },
            label: { Text("pop") }
        )
        .navigationTitle("설정화면")
    }
}

#Preview {
    RootView()
}

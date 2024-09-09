//
//  MainView.swift
//  CCRecorder
//
//  Created by 김용우 on 9/6/24.
//

import SwiftUI

struct MainView: View {
    @Environment(ViewCoordinator.self) private var viewCoordinator

    var body: some View {
        Button(
            action: { viewCoordinator.push(.setting) },
            label: { Text("설정 화면 이동") }
        )
    }
}

#Preview {
    MainView()
}

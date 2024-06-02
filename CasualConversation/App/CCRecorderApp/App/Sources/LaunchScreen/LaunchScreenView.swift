//
//  LaunchScreenView.swift
//  CCRecorderApp
//
//  Created by 김용우 on 6/2/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import SwiftUI

struct LaunchScreenView: View {
    
    @Binding var isLaunched: Bool
    
    var body: some View {
        Image("homex_00")
            .resizable()
            .scaledToFill()
            .background {
                Image("homex_00")
                    .resizable()
                    .ignoresSafeArea()
            }
            .task {
                // TODO: setup 코드 추가 필요
                Thread.sleep(forTimeInterval: 2.0) // 임시 로딩 시간
                
                await MainActor.run {
                    isLaunched.toggle()
                }
            }
    }
}

#Preview {
    LaunchScreenView(isLaunched: .constant(false))
}

//
//  LaunchScreenView.swift
//  CCRecorder
//
//  Created by 김용우 on 9/6/24.
//

import SwiftUI

struct LaunchScreenView: View {
    @Binding var state: LaunchState
        
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
                await launch()
            }
    }
    
}

extension LaunchScreenView {
    
    private func launch() async {
        do {
            try await Task.sleep(for: .seconds(2)) // FIXME: Launch Process
            
            state = .launched
        } catch {
            
        }
    }
    
}

#Preview {
    LaunchScreenView(state: .constant(.preprocess))
}

//
//  CasualConversationApp.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

@main
struct CasualConversationApp: App {
	
	private let appDIContainer = AppDIContainer()
    
    enum Status {
        case preprocess
        case launched
    }
    
    @State private var status: Status = .preprocess
	
    var body: some Scene {
        WindowGroup {
            switch status {
                case .preprocess:
                    LaunchScreenView(
                        isLaunched: .init(
                            get: { status == .launched },
                            set: {
                                if $0 {
                                    status = .launched
                                }
                            }
                        )
                    )
                case .launched:
                    appDIContainer.ContentView()
                        .environmentObject(appDIContainer.makePresentationDIContainer())
            }
        }
    }
    
}

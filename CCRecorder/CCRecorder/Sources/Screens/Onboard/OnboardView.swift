//
//  OnboardView.swift
//  CCRecorder
//
//  Created by 김용우 on 9/6/24.
//

import SwiftUI

struct OnboardView: View {
    
    struct Page {
        let id: Int
        var assetName: String { "iphoneX_\(id)" }
    }
    
    @State private var pages: [Page] = (0...4).map { Page(id: $0) }
    
    var body: some View {
        TabView {
            ForEach(pages.indices, id: \.self) { index in
                Image(pages[index].assetName)
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .bottom) {
                        if index == pages.count - 1 {
                            Button(
                                action: {
                                    
                                }, label: {
                                    Text("앱 시작하기")
                                        .tint(.white)
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .shadow(color: .black, radius: 1, x: 1, y: 1)
                                }
                            )
                            .buttonBorderShape(.roundedRectangle)
                        }
                    }
                    .clipShape(.rect(cornerRadius: 50))
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
    }
    
}

#Preview {
    OnboardView()
}

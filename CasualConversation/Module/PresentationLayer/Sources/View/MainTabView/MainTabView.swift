//
//  MainTabView.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import SwiftUI

struct MainTabView: View {
	
	@EnvironmentObject private var container: PresentationDIContainer
	@ObservedObject var viewModel: MainTabViewModel
	
	var body: some View {
		NavigationView {
			ParentView()
                .environmentObject(viewModel)
				.background(Color.ccBgColor)
				
                .navigationTitle(viewModel.title)
				.navigationBarTitleDisplayMode(.large)
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: container.SettingView()) {
                            Image(systemName: "gear")
                        }
					}
				}
                .fullScreenCover(isPresented: $viewModel.isPresentedRecordView) {
					container.recordView()
				}
		}
    }

}

// MARK: - Parent View
fileprivate struct ParentView: View {
    @EnvironmentObject private var container: PresentationDIContainer
    @EnvironmentObject private var viewModel: MainTabViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.selectedTab {
                case .conversations:
                    container.ConversationListView()
                case .notes:
                    container.NoteSetView()
            }
        }
        .overlay {
            VStack {
                Spacer()
                MainTab()
            }
        }
    }
    
}
// MARK: - Sub Views
fileprivate struct MainTab: View {
    @EnvironmentObject private var viewModel: MainTabViewModel
    
    var body: some View {
        HStack(alignment: .center) {
            CCTabItem(tab: .conversations)
            Button(
                action: {
                    viewModel.isPresentedRecordView.toggle()
                }, label: {
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
            CCTabItem(tab: .notes)
        }
        .padding()
        .background(Color.ccGroupBgColor)
    }
    
}

fileprivate struct CCTabItem: View {
    let tab: MainTabViewModel.Tab
    
    @EnvironmentObject private var viewModel: MainTabViewModel
    
    var body: some View {
        Button(
            action: { viewModel.selectedTab = tab },
            label: {
                Spacer()
                Image(systemName: viewModel.tabItemImageName)
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(viewModel.currentTintColor(from: tab))
                Spacer()
            }
        )
    }
    
}

// MARK: - Preview
#if DEBUG
extension MainTabView {
    
    init() {
        self.viewModel = .init()
    }
    
}
#endif

struct MainTabView_Previews: PreviewProvider {
		
	static var previews: some View {
		MainTabView()
			.preferredColorScheme(.light)
		MainTabView()
			.preferredColorScheme(.dark)
	}
	
}

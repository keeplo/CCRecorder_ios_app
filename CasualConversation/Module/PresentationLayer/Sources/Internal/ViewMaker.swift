//
//  ViewMaker.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Combine
import SwiftUI

final class ViewMaker: Dependency, ObservableObject {
    
	struct Dependency {
        let container: DependencyContainer
	}
	let dependency: Dependency
    
    private var preference: Preference = .shared
	
	init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}

public enum Screen {
    case mainTab
    case record
    case setting
    case noteDetail(NoteEntity)
    case playTab(ConversationEntity)
    case conversationList
    case selection(ConversationEntity)
    case noteSet(NoteUsecase?) // FIXME: 필터 방식 변경 필요
}

extension ViewMaker: ViewFactory {
    
    func makeRootView() -> AnyView {
        .init(
            makeView(.mainTab)
                .environmentObject(self)
                .accentColor(.ccAccentColor)
                .preferredColorScheme(preference.colorScheme)
        )
    }
    
}

extension ViewMaker {
    
    func makeView(_ screen: Screen) -> some View {
        let anyView: AnyView
        let container = dependency.container
        switch screen {
            case .mainTab:
                anyView = .init(MainTabView())
                
            case .record:
                let viewModel: RecordViewModel = .init(
                    dependency: .init(
                        useCase: container.resolve(ConversationUsecase.self)!,
                        audioService: container.resolve(CCRecorder.self)!
                    )
                )
                anyView = .init(RecordView(viewModel: viewModel))
                
            case .setting:
                let viewModel: SettingViewModel = .init(
                    dependency: .init(
                        mainURL: PresentationFactory.mainURL,
                        cafeURL: PresentationFactory.cafeURL,
                        eLearningURL: PresentationFactory.eLearningURL,
                        tasteURL: PresentationFactory.tasteURL,
                        testURL: PresentationFactory.testURL,
                        receptionTel: PresentationFactory.receptionTel
                    )
                )
                anyView = .init(SettingView(viewModel: viewModel))
                
            case .noteDetail(let note):
                let viewModel: NoteDetailViewModel = .init(dependency: .init(
                        useCase: container.resolve(NoteUsecase.self)!,
                        item: note
                    )
                )
                anyView = .init(NoteDetailView(viewModel: viewModel))
                
            case .playTab(let conversation):
                let viewModel: PlayTabViewModel = .init(dependency: .init(
                        item: conversation,
                        audioService: container.resolve(CCPlayer.self)!
                    )
                )
                anyView = .init(PlayTabView(viewModel: viewModel))
                
            case .conversationList:
                let viewModel: ConversationListViewModel = .init(
                    dependency: .init(
                        useCase: container.resolve(ConversationUsecase.self)!,
                        audioService: container.resolve(CCPlayer.self)!
                    )
                )
                anyView = .init(ConversationListView(viewModel: viewModel))
                
            case .selection(let conversation):
                let viewModel: SelectionViewModel = .init(
                    dependency: .init(
                        conversationUseCase: container.resolve(ConversationUsecase.self)!,
                        noteUsecase: container.resolve(NoteUsecase.self)!,
                        item: conversation
                    )
                )
                anyView = .init(SelectionView(viewModel: viewModel))
                
            case .noteSet(let usecase):
                let viewModel: NoteSetViewModel
                if let bindedUseCase = usecase {
                    viewModel = .init(dependency: .init(useCase: bindedUseCase))
                } else {
                    viewModel = .init(
                        dependency: .init(
                            useCase:container.resolve(NoteUsecase.self, name: "all")!
                        )
                    )
                }
                                      
                anyView = .init(NoteSetView(viewModel: viewModel))
                
        }

        return anyView
    }
}

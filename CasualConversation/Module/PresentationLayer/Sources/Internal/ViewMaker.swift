//
//  ViewMaker.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

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

enum Screen {
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
                anyView = .init(
                    NoteDetailView(
                        item: note,
                        usecase: container.resolve(NoteUsecase.self)!
                    )
                )
                
            case .playTab(let conversation):
                let viewModel: PlayTabViewModel = .init(dependency: .init(
                    item: conversation,
                    audioService: container.resolve(CCPlayer.self)!
                )
                )
                anyView = .init(PlayTabView(viewModel: viewModel))
                
            case .conversationList:
                anyView = .init(
                    ConversationListView(
                        usecase: container.resolve(ConversationUsecase.self)!,
                        player: container.resolve(CCPlayer.self)!
                    )
                )
                
            case .selection(let conversation):
                anyView = .init(
                    ConversationDetailView(
                        item: conversation,
                        conversationUseCase: container.resolve(ConversationUsecase.self)!,
                        noteUsecase: container.resolve(NoteUsecase.self)!
                    )
                )
                
            case .noteSet(let usecase):
                let noteSetView: NoteSetView
                if let bindedUseCase = usecase {
                    noteSetView = .init(usecase: bindedUseCase)
                } else {
                    noteSetView = .init(usecase: container.resolve(NoteUsecase.self, name: "all")!)
                }
                anyView = .init(noteSetView)
                
        }
        
        return anyView
    }
    
}

#if DEBUG
import Combine
struct FakeConversationUsecase: ConversationUsecase {
    var conversationSubejct: CurrentValueSubject<[Domain.ConversationEntity], Never> = .init([])
    func add(_ item: Domain.ConversationEntity, completion: (Common.CCError?) -> Void) {}
    func edit(after editedItem: Domain.ConversationEntity, completion: (Common.CCError?) -> Void) {}
    func delete(_ item: Domain.ConversationEntity, completion: (Common.CCError?) -> Void) {}
}

//struct FakeCCPlayer: CCPlayer {
//    var isPlayingPublisher: Published<Bool>.Publisher
//    var currentTimePublisher: Published<TimeInterval>.Publisher { .constant(.zero) }
//    var durationPublisher: Published<TimeInterval>.Publisher { .constant(10.0) }
//    
//    func stopTrackingCurrentTime() {}
//    func setupPlaying(filePath: URL, completion: (Common.CCError?) -> Void) {}
//    func startPlaying() {}
//    func pausePlaying() {}
//    func finishPlaying() {}
//    func seek(to time: Double) {}
//    func changePlayingRate(to value: Float) {}
//    func removeRecordFile(from filePath: URL, completion: (Common.CCError?) -> Void) {}
//}
#endif

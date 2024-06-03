//
//  PresentationDIContainer.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Combine
import SwiftUI

public final class PresentationDIContainer: Dependency, ObservableObject {
	
	public struct Dependency {
        let configurations: PresentationConfiguarations
		let conversationUsecase: ConversationUsecase
		let noteUsecase: NoteUsecase
		let audioRecordService: AudioRecordService
        let audioPlayService: AudioPlayService
		
		public init(
            configurations: PresentationConfiguarations,
            conversationUsecase: ConversationUsecase,
            noteUsecase: NoteUsecase,
            audioRecordService: AudioRecordService,
            audioPlayService: AudioPlayService
		) {
			self.configurations = configurations
			self.conversationUsecase = conversationUsecase
			self.noteUsecase = noteUsecase
			self.audioRecordService = audioRecordService
            self.audioPlayService = audioPlayService
		}
	}
	
	public let dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
}

public enum Screen {
    case main
    case record
}

public extension PresentationDIContainer {
    
    func makeView(_ screen: Screen) -> some View {
        let anyView: AnyView
        
        switch screen {
            case .main:
                anyView = .init(MainTabView())
            case .record:
                let viewModel: RecordViewModel = .init(
                    dependency: .init(
                        useCase: self.dependency.conversationUsecase,
                        audioService: self.dependency.audioRecordService
                    )
                )
                anyView = .init(RecordView(viewModel: viewModel))
        }

        return anyView
    }
}

extension PresentationDIContainer {
	
	var configurations: PresentationConfiguarations {
		self.dependency.configurations
	}
		
	func recordView() -> RecordView {
		let viewModel: RecordViewModel = .init(
            dependency: .init(
				useCase: self.dependency.conversationUsecase,
				audioService: self.dependency.audioRecordService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func ConversationListView() -> ConversationListView {
		let viewModel: ConversationListViewModel = .init(
            dependency: .init(
                useCase: self.dependency.conversationUsecase,
				audioService: self.dependency.audioPlayService
			)
		)
		return .init(viewModel: viewModel)
	}
    
    func ConversationListRow(selected conversation: ConversationEntity) -> ConversationListRow {
        let viewModel: ConversationListRowViewModel = .init(
            dependency: .init(
                item: conversation
            )
        )
        return .init(viewModel: viewModel)
    }
    
    func SelectionView(selected conversation: ConversationEntity) -> SelectionView {
        let viewModel: SelectionViewModel = .init(
            dependency: .init(
				conversationUseCase: self.dependency.conversationUsecase,
                noteUsecase: self.dependency.noteUsecase,
				item: conversation
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func NoteSetView(by usecase: NoteUsecase? = nil) -> NoteSetView {
		let viewModel: NoteSetViewModel
		if let bindedUseCase = usecase {
			viewModel = .init(dependency: .init(useCase: bindedUseCase))
		} else {
			viewModel = .init(dependency: .init(useCase: self.dependency.noteUsecase))
		}
		return .init(viewModel: viewModel)
	}
	
	func NoteSetRow(by note: NoteEntity) -> NoteSetRow {
		let viewModel: NoteSetRowViewModel = .init(dependency: .init(
			item: note)
		)
		return .init(viewModel: viewModel)
	}
	
	func SettingView() -> SettingView {
		let viewModel: SettingViewModel = .init()
		return .init(viewModel: viewModel)
	}
	
	func PlayTabView(with conversation: ConversationEntity) -> PlayTabView {
		let viewModel: PlayTabViewModel = .init(dependency: .init(
				item: conversation,
				audioService: self.dependency.audioPlayService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func NoteDetailView(selected note: NoteEntity) -> NoteDetailView {
		let viewModel: NoteDetailViewModel = .init(dependency: .init(
				useCase: self.dependency.noteUsecase,
				item: note
			)
		)
		return .init(viewModel: viewModel)
	}
	
}

//
//  PresentationDIContainer.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import CommonLayer
import DomainLayer

import Combine
import SwiftUI

public final class PresentationDIContainer: Dependency, ObservableObject {
	
	public struct Dependency {
        let configurations: PresentationConfiguarations
		let conversationUseCase: ConversationUseCase
		let noteUseCase: NoteUseCase
		let audioRecordService: AudioRecordService
        let audioPlayService: AudioPlayService
		
		public init(
            configurations: PresentationConfiguarations,
            conversationUseCase: ConversationUseCase,
            noteUseCase: NoteUseCase,
            audioRecordService: AudioRecordService,
            audioPlayService: AudioPlayService
		) {
			self.configurations = configurations
			self.conversationUseCase = conversationUseCase
			self.noteUseCase = noteUseCase
			self.audioRecordService = audioRecordService
            self.audioPlayService = audioPlayService
		}
	}
	
	public var dependency: Dependency
	
	public init(dependency: Dependency) {
		self.dependency = dependency
	}
	
//	private func makeNoteUseCase(filter item: Conversation) -> NoteUseCase {
//		return .init(
//            dependency: .init(
//                dataController: self.dependency.noteRepository,
//                filter: .selected(item)
//            )
//		)
//	}
	
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
                let viewModel: MainTabViewModel = .init()
                anyView = .init(MainTabView(viewModel: viewModel))
            case .record:
                let viewModel: RecordViewModel = .init(
                    dependency: .init(
                        useCase: self.casualConversationUseCase,
                        audioService: self.audioRecordService
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
	
	func mainView() -> MainTabView {
		let viewModel: MainTabViewModel = .init()
		return .init(viewModel: viewModel)
	}
	
	func recordView() -> RecordView {
		let viewModel: RecordViewModel = .init(dependency: .init(
				useCase: self.casualConversationUseCase,
				audioService: self.audioRecordService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func ConversationListView() -> ConversationListView {
		let viewModel: ConversationListViewModel = .init(dependency: .init(
				useCase: self.casualConversationUseCase,
				audioService: self.audioPlayService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func ConversationListRow(selected conversation: Conversation) -> ConversationListRow {
		let viewModel: ConversationListRowViewModel = .init(dependency: .init(
			item: conversation)
		)
		return .init(viewModel: viewModel)
	}
	
	func SelectionView(selected conversation: Conversation) -> SelectionView {
		let viewModel: SelectionViewModel = .init(dependency: .init(
				conversationUseCase: self.casualConversationUseCase,
				noteUseCase: makeNoteUseCase(filter: conversation),
				item: conversation
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func NoteSetView(by usecase: NoteManagable? = nil) -> NoteSetView {
		let viewModel: NoteSetViewModel
		if let bindedUseCase = usecase {
			viewModel = .init(dependency: .init(useCase: bindedUseCase))
		} else {
			viewModel = .init(dependency: .init(useCase: self.noteUseCase))
		}
		return .init(viewModel: viewModel)
	}
	
	func NoteSetRow(by note: Note) -> NoteSetRow {
		let viewModel: NoteSetRowViewModel = .init(dependency: .init(
			item: note)
		)
		return .init(viewModel: viewModel)
	}
	
	func SettingView() -> SettingView {
		let viewModel: SettingViewModel = .init()
		return .init(viewModel: viewModel)
	}
	
	func PlayTabView(with conversation: Conversation) -> PlayTabView {
		let viewModel: PlayTabViewModel = .init(dependency: .init(
				item: conversation,
				audioService: self.audioPlayService
			)
		)
		return .init(viewModel: viewModel)
	}
	
	func NoteDetailView(selected note: Note) -> NoteDetailView {
		let viewModel: NoteDetailViewModel = .init(dependency: .init(
				useCase: self.noteUseCase,
				item: note
			)
		)
		return .init(viewModel: viewModel)
	}
	
}

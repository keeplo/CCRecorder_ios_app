//
//  AppDIContainer.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/07/03.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import CommonLayer
import DataLayer
import DomainLayer
import PresentationLayer

import Foundation

final class AppDIContainer {
    
    private let configurations = AppConfigurations()
    
    // MARK: - Repository
    private lazy var fileManagerReposotiry: FileManagerRepositoryProtocol = FileManagerRepository()
    
    private lazy var conversationDataContorller: ConversationRepository = DataFactory.makeConversationRepository()
    private lazy var noteDataController: NoteRepository = DataFactory.makeNoteRepository()
    private lazy var recordDataController: RecordRepository = DataFactory.makeRecordRepository(
        of: FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
    )
    
    func makePresentationDIContainer() -> PresentationDIContainer {
        return .init(
            dependency: .init(
                configurations: .init(
                    dependency: .init(
                        mainURL: URL(string: configurations.mainURL)!,
                        cafeURL: URL(string: configurations.cafeURL)!,
                        eLearningURL: URL(string: configurations.eLearningURL)!,
                        tasteURL: URL(string: configurations.tasteURL)!,
                        testURL: URL(string: configurations.testURL)!,
                        receptionTel: URL(string: configurations.receptionTel)!
                    )
                ),
                conversationUseCase: ConversationUseCase(dependency: .init(dataController: self.conversationDataContorller)),
                noteUseCase: NoteUseCaseLegacy(dependency: .init(dataController: self.noteDataController, filter: .all)),
                audioRecordService: .init(dependency: .init(dataController: self.recordDataController)),
                audioPlayService: .init(dependency: .init(dataController: self.recordDataController))
            )
        )
    }
    
    func ContentView() -> ContentView {
        return .init()
    }
    
}

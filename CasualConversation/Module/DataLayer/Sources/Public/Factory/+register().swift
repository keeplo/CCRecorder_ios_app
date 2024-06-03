//
//  +register().swift
//  Data
//
//  Created by 김용우 on 6/2/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Common
import Swinject
import Domain

import Foundation

extension DataFactory {
    
    public func register(_ container: Container) {
        container.register(CoreDataStack.self) { _ in
            CoreDataStack()
        }
        .inObjectScope(.container)
        
        container.register(ConversationRepository.self) { resolver in
            ConversationDataController(
                dependency: .init(
                    coreDataStack: resolver.resolve(CoreDataStack.self)!
                )
            )
        }
        .inObjectScope(.container)
        
        container.register(NoteRepository.self) { resolver in
            NoteDataController(
                dependency: .init(
                    coreDataStack: resolver.resolve(CoreDataStack.self)!
                )
            )
        }
        .inObjectScope(.container)
        
        container.register(RecordRepository.self) { resolver in
            RecordDataController(
                dependency: .init(
                    documentURL: FileManager.default.urls(
                        for: .documentDirectory,
                        in: .userDomainMask
                    )[0]
                )
            )
        }
    }
    
}

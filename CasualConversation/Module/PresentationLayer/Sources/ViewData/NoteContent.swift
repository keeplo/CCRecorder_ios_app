//
//  NoteContent.swift
//  CCRecorderApp
//
//  Created by 김용우 on 3/30/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Foundation

import CommonLayer
import DomainLayer

struct NoteContent: Note {
    let id: Identifier
    let original: String
    let translation: String
    let category: Category
    let references: [Identifier]
    let createdDate: Date
}

extension Category {
    
    init(of entity: NoteCategory) {
        switch entity {
            case .vocabulary:       self = .vocabulary
            case .sentence:         self = .sentence
        }
    }
    
}

extension NoteContent {
    init(of entity: NoteEntity) {
        self.id = entity.id
        self.original = entity.original
        self.translation = entity.translation
        self.category = .init(of: entity.category)
        self.references = entity.references
        self.createdDate = entity.createdDate
    }
}

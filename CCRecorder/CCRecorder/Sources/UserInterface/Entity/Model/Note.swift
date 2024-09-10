//
//  Note.swift
//  CCRecorder
//
//  Created by 김용우 on 9/9/24.
//

import Foundation
import SwiftData

@Model
final class Note {
    #Unique<Note>([\.id])
    
    enum Category: Codable {
        case vocabulary
        case sentence
    }
    
    let id: UUID
    let createdDate: Date
    var original: String
    var translation: String
    var category: Category
    
    init(
        id: UUID = .init(),
        createdDate: Date = .init(),
        original: String,
        translation: String,
        category: Category
    ) {
        self.id = id
        self.createdDate = createdDate
        self.original = original
        self.translation = translation
        self.category = category
    }
    
}

extension Note {
    
    var isDone: Bool            { !original.isEmpty && !translation.isEmpty }
    
}

#if DEBUG
extension Note {
    
    static var vocabularyDummy: Self {
        .init(
            original: "Test",
            translation: "",
            category: .vocabulary
        )
    }
    static var sentenceDummy: Self {
        .init(
            original: "",
            translation: "테스트 용 문장을 이렇게 작성함",
            category: .sentence
        )
    }
    
}
#endif

//
//  ConversationContent.swift
//  CCRecorderApp
//
//  Created by 김용우 on 3/30/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Foundation

import Common
import Domain

struct ConversationContent: Conversation {
    let id: Identifier
    let title: String?
    let topic: String?
    let members: [String]
    let recordFilePath: URL
    let recordedDate: Date
    let pins: [TimeInterval]
}

extension ConversationContent {
    
    init(of entity: ConversationEntity) {
        self.id = entity.id
        self.title = entity.title
        self.topic = entity.topic
        self.members = entity.members
        self.recordFilePath = entity.recordFilePath
        self.recordedDate = entity.recordedDate
        self.pins = entity.pins
    }
    
}

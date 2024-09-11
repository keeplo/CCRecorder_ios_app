//
//  Conversation.swift
//  CCRecorder
//
//  Created by 김용우 on 9/9/24.
//

import Foundation
import SwiftData

@Model
final class Conversation {
    #Unique<Conversation>([\.id])
    
    let id: UUID
    let createdDate: Date
    let recordFilePath: URL
    let pins: [TimeInterval]
    var title: String
    var topic: String
    var noteIds: [UUID]
    @Relationship var members: [Memeber]
    
    init(
        id: UUID = .init(),
        createdDate: Date = .init(),
        recordFilePath: URL,
        pins: [TimeInterval] = [],
        title: String,
        topic: String,
        notes: [UUID] = [],
        members: [Memeber]
    ) {
        self.id = id
        self.createdDate = createdDate
        self.recordFilePath = recordFilePath
        self.pins = pins
        self.title = title
        self.topic = topic
        self.noteIds = notes
        self.members = members
    }
    
}

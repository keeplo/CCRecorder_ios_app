//
//  Screen.swift
//  CCRecorder
//
//  Created by 김용우 on 9/6/24.
//

import Foundation

enum Screen: Hashable {
    case conversationList
    case conversationDetail(Conversation)
    case setting
}

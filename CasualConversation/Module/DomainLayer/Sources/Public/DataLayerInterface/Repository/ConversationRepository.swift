//
//  ConversationRepository.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import CommonLayer
import DomainLayer

import Combine

public protocol ConversationRepository {
    var dataSourceSubject: CurrentValueSubject<[Conversation], DataError> { get }
	func fetch() -> [Conversation]?
	func create(_ item: Conversation, completion: (CCError?) -> Void)
	func update(after updatedItem: Conversation, completion: (CCError?) -> Void)
	func delete(_ item: Conversation, completion: (CCError?) -> Void)
}

//
//  ConversationUsecaseType.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import Common

import Foundation.NSURL
import Combine

public final class ConversationUsecaseType: Dependency, ConversationUsecase {
	
    public struct Dependency {
		let dataController: ConversationRepository
		
		public init(dataController: ConversationRepository) {
			self.dataController = dataController
		}
	}
	
    public let dependency: Dependency
	
    public var conversationSubejct: CurrentValueSubject<[ConversationEntity], Never> = .init([])
	
    public init(dependency: Dependency) {
		self.dependency = dependency
		fetchDataSource()
	}
	
	private func fetchDataSource() {
		guard let fetcedList = dependency.dataController.fetch() else {
			CCError.log.append(.log("Failure fetchDataSource"))
			return
		}
        self.conversationSubejct.send(fetcedList)
	}
 
}

// MARK: - ConversationRecodable
extension ConversationUsecaseType {
	
    public func add(_ item: ConversationEntity, completion: (CCError?) -> Void) {
		self.dependency.dataController.create(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
}

// MARK: - ConversationMaintainable
extension ConversationUsecaseType {
	
    public func edit(after editedItem: ConversationEntity, completion: (CCError?) -> Void) {
		self.dependency.dataController.update(after: editedItem) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
    public func delete(_ item: ConversationEntity, completion: (CCError?) -> Void) {
		self.dependency.dataController.delete(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
}

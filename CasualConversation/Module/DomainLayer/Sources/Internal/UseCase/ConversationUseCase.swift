//
//  ConversationUseCase.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/28.
//

import CommonLayer

import Foundation.NSURL
import Combine

public protocol ConversationManagable: ConversationRecodable, ConversationMaintainable { }

public protocol ConversationRecodable {
	func add(_ item: ConversationEntity, completion: (CCError?) -> Void)
}

public protocol ConversationMaintainable {
	var dataSourcePublisher: Published<[ConversationEntity]>.Publisher { get }
	func edit(after editedItem: ConversationEntity, completion: (CCError?) -> Void)
	func delete(_ item: ConversationEntity, completion: (CCError?) -> Void)
}

public final class ConversationUseCase: Dependency, ConversationManagable {
	
	public struct Dependency {
		let dataController: ConversationRepository
		
		public init(dataController: ConversationRepository) {
			self.dataController = dataController
		}
	}
	
	public let dependency: Dependency
	
	@Published private var dataSource: [ConversationEntity] = []
	public var dataSourcePublisher: Published<[ConversationEntity]>.Publisher { $dataSource }
	
	public init(dependency: Dependency) {
		self.dependency = dependency
		fetchDataSource()
	}
	
	private func fetchDataSource() {
		guard let fetcedList = dependency.dataController.fetch() else {
			CCError.log.append(.log("Failure fetchDataSource"))
			return
		}
		self.dataSource = fetcedList
	}
 
}

// MARK: - ConversationRecodable
extension ConversationUseCase {
	
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
extension ConversationUseCase {
	
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

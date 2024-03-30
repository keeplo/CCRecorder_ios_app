//
//  NoteUseCaseLegacy.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import CommonLayer

import Combine

public protocol NoteManagable {
	var dataSourcePublisher: Published<[NoteEntity]>.Publisher { get }
	func add(item: NoteEntity, completion: (CCError?) -> Void)
	func edit(_ newItem: NoteEntity, completion: (CCError?) -> Void)
	func delete(item: NoteEntity, completion: (CCError?) -> Void)
}

public final class NoteUseCaseLegacy: Dependency {
	
	public enum Filter {
		case all
		case selected(ConversationEntity)
	}
	
	public struct Dependecy {
		let dataController: NoteRepository
		var filter: Filter
		
		public init(
			dataController: NoteRepository,
			filter: Filter
		) {
			self.dataController = dataController
			self.filter = filter
		}
	}
	
	public var dependency: Dependecy
	
	@Published private var dataSource: [NoteEntity] = []
	public var dataSourcePublisher: Published<[NoteEntity]>.Publisher { $dataSource }
	
	public init(dependency: Dependecy) {
		self.dependency = dependency
		fetchDataSource()
	}
	
	private func fetchDataSource() {
		let fetcedList: [NoteEntity]
		switch dependency.filter {
		case .all:
			fetcedList = dependency.dataController.fetch() ?? []
		case .selected(let item):
            fetcedList = dependency.dataController.fetch() ?? []
		}
		self.dataSource = fetcedList.filter({ !$0.isDone }) + fetcedList.filter({ $0.isDone })
	}
	
}

extension NoteUseCaseLegacy: NoteManagable {
	
	public func add(item: NoteEntity, completion: (CCError?) -> Void) {
		self.dependency.dataController.create(item) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
	public func edit(_ newItem: NoteEntity, completion: (CCError?) -> Void) {
		self.dependency.dataController.update(after: newItem) { error in
			guard error == nil else {
				completion(error)
				return
			}
			fetchDataSource()
			completion(nil)
		}
	}
	
	public func delete(item: NoteEntity, completion: (CCError?) -> Void) {
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

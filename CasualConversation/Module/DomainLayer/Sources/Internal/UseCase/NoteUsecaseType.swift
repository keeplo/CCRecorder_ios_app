//
//  NoteUsecaseType.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common

import Combine

public final class NoteUsecaseType: Dependency, NoteUsecase {
	
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
	
    public var noteSubject: CurrentValueSubject<[NoteEntity], Never> = .init([])
	
	public init(dependency: Dependecy) {
		self.dependency = dependency
		fetchDataSource()
	}
	
	private func fetchDataSource() {
		let fetcedList: [NoteEntity]
		switch dependency.filter {
		case .all:
			fetcedList = dependency.dataController.fetch() ?? []
            case .selected(_):
            fetcedList = dependency.dataController.fetch() ?? []
		}
        self.noteSubject.send(fetcedList.filter({ !$0.isDone }) + fetcedList.filter({ $0.isDone }))
	}
	
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

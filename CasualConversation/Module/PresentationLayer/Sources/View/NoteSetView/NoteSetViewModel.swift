//
//  NoteSetViewModel.swift
//  CasualConversation
//
//  Created by Yongwoo Marco on 2022/06/23.
//

import Common
import Domain

import SwiftUI
import Combine

final class NoteSetViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let useCase: NoteUsecase
	}
	
	let dependency: Dependency
	
	@Published var list: [NoteEntity] = []
    
    private var cancellableSet: Set<AnyCancellable> = []
	
	init(dependency: Dependency) {
		self.dependency = dependency
		
        bind()
	}
	
}

extension NoteSetViewModel {
	
	func removeRows(at offsets: IndexSet) {
		for offset in offsets.sorted(by: >) {
			self.dependency.useCase.delete(item: list[offset]) { error in
				guard error == nil else {
					CCError.log.append(error!)
					return
				}
			}
		}
	}
	
}

extension NoteSetViewModel {
    
    func bind() {
        self.dependency.useCase.noteSubject
            .sink { [weak self] notes in
                self?.list = notes
            }
            .store(in: &cancellableSet)
    }
    
}

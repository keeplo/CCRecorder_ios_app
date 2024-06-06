//
//  ConversationListViewModel.swift
//  Domain
//
//  Created by Yongwoo Marco on 2022/07/04.
//  Copyright © 2022 pseapplications. All rights reserved.
//

import Common
import Domain

import Foundation
import Combine

final class ConversationListViewModel: Dependency, ObservableObject {
	
	struct Dependency {
		let useCase: ConversationUsecase
		let audioService: CCPlayer
	}
	
	let dependency: Dependency
	
	@Published var list: [ConversationEntity] = []
	
	private var cancellableSet: Set<AnyCancellable> = []
	
	init(dependency: Dependency) {
		self.dependency = dependency
			
        bind()
	}
	
}

extension ConversationListViewModel {
	
	func removeRows(at offsets: IndexSet) {
		for offset in offsets.sorted(by: >) {
			let item = list[offset]
			self.dependency.audioService.removeRecordFile(from: item.recordFilePath) { error in
				if error != nil {
					CCError.log.append(error!)
				}
			}
			self.dependency.useCase.delete(item) { error in
				guard error == nil else {
					CCError.log.append(error!)
					return
				}
			}
		}
	}
	
}

extension ConversationListViewModel {
    
    private func bind() {
        self.dependency.useCase.conversationSubejct
            .sink { [weak self] conversations in
                self?.list = conversations
            }
            .store(in: &cancellableSet)
    }
    
}

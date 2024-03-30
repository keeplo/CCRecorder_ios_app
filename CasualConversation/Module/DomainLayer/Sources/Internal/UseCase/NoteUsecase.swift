//
//  NoteUsecase.swift
//  DomainLayer
//
//  Created by 김용우 on 3/10/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Combine

public protocol NoteUsecase {
    var noteSubject: CurrentValueSubject<[NoteEntity], DomainError> { get }
    func add(_ item: NoteEntity) async
    func edit(_ newItem: NoteEntity) async
    func delete(_ item: NoteEntity) async
}

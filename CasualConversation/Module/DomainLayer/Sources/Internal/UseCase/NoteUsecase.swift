//
//  NoteUsecase.swift
//  DomainLayer
//
//  Created by 김용우 on 3/10/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Combine

public protocol NoteUsecase {
    var noteSubject: CurrentValueSubject<[Note], DomainError> { get }
    func add(_ item: Note) async
    func edit(_ newItem: Note) async
    func delete(_ item: Note) async
}

//
//  ViewModel.swift
//  CCRecorderApp
//
//  Created by 김용우 on 3/24/24.
//  Copyright © 2024 pseapplications. All rights reserved.
//

import Combine

protocol ViewModel: ObservableObject {
    associatedtype Action
    
    func action(_ action: Action)
}


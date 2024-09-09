//
//  ViewCoordinator.swift
//  CCRecorder
//
//  Created by 김용우 on 9/6/24.
//

import Foundation

@Observable final class ViewCoordinator {
    var path: [Screen] = []
    
    func push(_ screens: Screen...) {
        path.append(contentsOf: screens)
    }
    
    func pop(of count: Int = 1) {
        path.removeLast(count)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
}

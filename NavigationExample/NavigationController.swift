//
//  NavigationController.swift
//  LuxuryEscapes
//
//  Created by Pavlo Dmytriiev on 18.11.2025.
//

import SwiftUI

@MainActor
public protocol NavigationController: AnyObject {
    /// The number of elements in this path.
    var count: Int { get }

    /// A Boolean that indicates whether this path is empty.
    var isEmpty: Bool { get }

    func append<V>(_ value: V) where V: Hashable
    func removeLast(_ count: Int)
}

public extension NavigationController {
    func removeLast() {
        removeLast(1)
    }
}

@MainActor @Observable
final class NavigationControllerImpl: NavigationController {
    var navigationController = NavigationPath()

    var count: Int {
        navigationController.count
    }

    var isEmpty: Bool {
        navigationController.isEmpty
    }

    func append<V>(_ value: V) where V: Hashable {
        navigationController.append(value)
    }

    func removeLast(_ count: Int) {
        navigationController.removeLast(count)
    }
}

@MainActor
final class MockNavigationController: NavigationController {
    let count = 0

    let isEmpty = true

    func append<V>(_ value: V) where V: Hashable { }
    func removeLast(_ count: Int) { }
}

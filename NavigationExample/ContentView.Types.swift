//
//  ContentView.Types.swift
//  NavigationExample
//
//  Created by Pavlo Dmytriiev on 13.01.2026.
//

extension ContentView {
    enum Destination {
        case firstChild
        case secondChild(initialName: String?, onComplete: (String?) -> Void)
    }
}

extension ContentView.Destination: Identifiable {
    var id: String {
        switch self {
        case .firstChild:
            return "firstChild"
        case let .secondChild(initialName: name, onComplete: _):
            return "secondChild_\(name, default: "nil")"
        }
    }
}

extension ContentView.Destination: Equatable {
    static func == (lhs: ContentView.Destination, rhs: ContentView.Destination) -> Bool {
        switch (lhs, rhs) {
        case (.firstChild, .firstChild):
            return true
        case let (.secondChild(initialName: lName, onComplete: _),
                  .secondChild(initialName: rName, onComplete: _)):
            return lName == rName
        default:
            return false
        }
    }
}

extension ContentView.Destination: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .firstChild:
            hasher.combine(0)
        case let .secondChild(initialName: name, onComplete: _):
            hasher.combine(1)
            hasher.combine(name)
        }
    }
}


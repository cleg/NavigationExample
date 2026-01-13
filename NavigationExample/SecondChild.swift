//
//  SecondChild.swift
//  NavigationExample
//
//  Created by Pavlo Dmytriiev on 13.01.2026.
//

import SwiftUI

/// More complex view that take parameter and returns result via callback.
/// We use explicit parameters that are simple types and closure to return result to make view interface
/// and side effects simple and predictable.
struct SecondChild: View {
    @State private var name: String
    private let onComplete: (String) -> Void

    init(
        initialName: String?,
        onComplete: @escaping (String) -> Void
    ) {
        self._name = .init(initialValue: initialName ?? "")
        self.onComplete = onComplete
    }

    var body: some View {
        VStack {
            TextField("User name", text: $name)
                .textFieldStyle(.roundedBorder)

            Button(
                action: {
                    onComplete(name)
                },
                label: {
                    Text("Complete")
                }
            )
            .buttonStyle(.borderedProminent)
            .disabled(name.isEmpty)
        }
        .padding()
    }
}

#Preview {
    SecondChild(
        initialName: "John Doe",
        onComplete: { _ in }
    )
}

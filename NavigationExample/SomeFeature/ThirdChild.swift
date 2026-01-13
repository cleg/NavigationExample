//
//  ThirdChild.swift
//  NavigationExample
//
//  Created by Pavlo Dmytriiev on 13.01.2026.
//

import SwiftUI

struct ThirdChild: View {
    private let navigationController: any NavigationController

    init(navigationController: any NavigationController) {
        self.navigationController = navigationController
    }

    var body: some View {
        VStack {
            Text("Third Child View")
            Button(
                action: {
                    // for simple flows we can navigate on the view level
                    navigationController.append(Destination.grandchild)
                },
                label: {
                    Label("Show grandchild", systemImage: "arrow.right.circle")
                }
            )
        }
        .navigationTitle("Child 3")
        .navigationDestination(for: Destination.self) { destination in
            destinationView(for: destination)
        }
    }

    @ViewBuilder
    private func destinationView(for destination: Destination) -> some View {
        switch destination {
        case .grandchild:
            Grandchild()
        }
    }
}

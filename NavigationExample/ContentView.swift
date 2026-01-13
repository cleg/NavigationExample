//
//  ContentView.swift
//  NavigationExample
//
//  Created by Pavlo Dmytriiev on 13.01.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ViewModel
    private let navigationController: any NavigationController

    init(navigationController: any NavigationController) {
        self.navigationController = navigationController
        self._viewModel = StateObject(wrappedValue: ViewModel(navigationController: navigationController))
    }

    var body: some View {
        VStack {
            Button(
                action: {
                    viewModel.showFirstChild()
                },
                label: {
                    Label("First child", systemImage: "1.circle")
                }
            )
            .padding(.bottom)

            Text("Name: \(viewModel.name, default: "N/A")")

            Button(
                action: {
                    viewModel.showSecondChild()
                },
                label: {
                    Label("Edit name", systemImage: "pencil.circle")
                }
            )
            .padding(.bottom)

            Button(
                action: {
                    viewModel.showThirdChild()
                },
                label: {
                    Label("Third child", systemImage: "3.circle")
                }
            )
        }
        .buttonStyle(.borderedProminent)
        .padding()
        .navigationTitle("Our root view")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: Destination.self) { destination in
            destinationView(for: destination)
        }
    }

    @ViewBuilder
    private func destinationView(for destination: Destination) -> some View {
        switch destination {
        case .firstChild:
            FirstChild()
        case let .secondChild(initialName, onComplete):
            SecondChild(
                initialName: initialName,
                onComplete: onComplete
            )
        case .thirdChild:
            ThirdChild(navigationController: navigationController)
        }
    }
}

#Preview {
    NavigationStack {
        ContentView(navigationController: MockNavigationController())
    }
}

//
//  ContentView.swift
//  NavigationExample
//
//  Created by Pavlo Dmytriiev on 13.01.2026.
//

import SwiftUI

/// Our app's root view. Despite being a root view, it still receives a navigation controller from the outside.
/// This gives us the flexibility to embed this view into another navigation flow if needed.
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

            Button(
                action: {
                    viewModel.showThirdChildModal()
                },
                label: {
                    Label("Third child modal", systemImage: "3.circle.fill")
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
        .sheet(item: $viewModel.sheet) { sheet in
            sheetView(for: sheet)
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

    @ViewBuilder
    private func sheetView(for sheet: Sheet) -> some View {
        switch sheet {
        case let .thirdChildModal(onClose):
            // For model presentation of subflows, we need to wrap them into NavigationControllerWrapper and
            // reconfigure navigation bar if needed
            NavigationControllerWrapper { controller in
                ThirdChild(navigationController: controller)
                    .navigationBarTitleDisplayMode(.inline)
                    .navBarCloseButton(action: onClose)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView(navigationController: MockNavigationController())
    }
}

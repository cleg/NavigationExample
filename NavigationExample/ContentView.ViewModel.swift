//
//  ContentView.ViewModel.swift
//  NavigationExample
//
//  Created by Pavlo Dmytriiev on 13.01.2026.
//

import Combine
import Foundation

extension ContentView {
    @MainActor
    final class ViewModel: ObservableObject {
        private let navigationController: any NavigationController

        @Published private(set) var name: String?
        @Published var sheet: Sheet?

        init(navigationController: any NavigationController) {
            self.navigationController = navigationController
        }

        private func navigate(to destination: Destination) {
            navigationController.append(destination)
        }

        func showFirstChild() {
            navigate(to: .firstChild)
        }

        func showSecondChild() {
            navigate(
                to: .secondChild(
                    initialName: name,
                    onComplete: { [weak self] newName in
                        guard let self else { return }

                        navigationController.removeLast()
                        if let newName {
                            name = newName
                        }
                    }
                )
            )
        }

        func showThirdChild() {
            navigate(to: .thirdChild)
        }

        func showThirdChildModal() {
            sheet = .thirdChildModal(
                onClose: { [weak self] in
                    self?.sheet = nil
                }
            )
        }
    }
}

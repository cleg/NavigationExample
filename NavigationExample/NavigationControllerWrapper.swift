//
//  NavigationControllerWrapper.swift
//  LuxUI
//
//  Created by Pavlo Dmytriiev on 12.01.2026.
//

import SwiftUI

public struct NavigationControllerWrapper<Content: View>: View {
    @State private var controller = NavigationControllerImpl()

    @ViewBuilder let content: (any NavigationController) -> Content

    public init(
        @ViewBuilder content: @escaping (any NavigationController) -> Content
    ) {
        self.content = content
    }

    public var body: some View {
        NavigationStack(path: $controller.navigationController) {
            content(controller)
        }
    }
}

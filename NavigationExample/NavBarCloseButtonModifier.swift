//
//  NavBarCloseButtonModifier.swift
//  NavigationExample
//
//  Created by Pavlo Dmytriiev on 13.01.2026.
//

import Foundation
import SwiftUI

extension View {
    func navBarCloseButton(action: @escaping () -> Void) -> some View {
        self.modifier(NavBarCloseButtonModifier(action: action))
    }
}

private struct NavBarCloseButtonModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(
                        action: action,
                        label: {
                            Image(systemName: "xmark")
                                .imageScale(.large)
                        }
                    )
                }
            }
    }
}


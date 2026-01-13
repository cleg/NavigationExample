//
//  FirstChild.swift
//  NavigationExample
//
//  Created by Pavlo Dmytriiev on 13.01.2026.
//

import SwiftUI

/// Simplest example of child view, it doesn't require parameters and dependencies.
struct FirstChild: View {
    var body: some View {
        Text("First Child View")
            .navigationTitle("Child 1")
    }
}

#Preview {
    FirstChild()
}

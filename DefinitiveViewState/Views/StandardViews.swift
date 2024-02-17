//
//  StandardViews.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

struct StandardProgressView: View {
    var body: some View {
        ProgressView()
    }
}

struct StandardEmptyView: View {
    let message: String
    var body: some View {
        VStack {
            Text(message)
                .foregroundStyle(.secondary)
        }
    }
}

struct StandardErrorView: View {
    let message: String
    let retry: (() -> Void)?
    var body: some View {
        VStack(spacing: 20) {
            Text(message)
                .foregroundStyle(.red)
            if let retry {
                Button(action: retry) {
                    Text("Retry")
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        StandardProgressView()
        StandardEmptyView(message: "You're empty,mister!")
        StandardErrorView(message: "Error loading data", retry: {})
    }
}

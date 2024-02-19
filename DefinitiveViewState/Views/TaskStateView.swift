//
//  TaskStateView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

struct TaskStateView: View {
    @StateObject var viewModel = StateViewModel()
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                StandardProgressView()
                    .task {
                        await viewModel.load()
                    }
            case let .loaded(accounts):
                AccountsListView(accounts: accounts)
            case let .empty(message):
                StandardEmptyView(message: message)
            case let .error(message):
                StandardErrorView(message: message) {
                    viewModel.state = .loading
                }
            }
        }
        .navigationTitle("Accounts")
    }
}

#Preview {
    StateView()
}

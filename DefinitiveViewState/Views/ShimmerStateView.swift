//
//  ShimmerStateView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

struct ShimmerStateView: View {
    @StateObject var viewModel = StateViewModel()
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .loading:
                    AccountsListView(accounts: AccountManager.mock)
                        .redacted(reason: .placeholder)
                        .shimmering()
                        .task {
                            await viewModel.load()
                        }
                case let .loaded(accounts):
                    AccountsListView(accounts: accounts)
                case let .empty(message):
                    StandardEmptyView(message: message)
                case let .error(message):
                    StandardErrorView(message: message, retry: {
                        viewModel.state = .loading
                    })
                }
            }
            .navigationTitle("Accounts")
        }
    }
}

#Preview {
    ShimmerStateView()
}

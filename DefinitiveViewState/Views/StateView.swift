//
//  ClassicStateView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

struct StateView: View {
    @StateObject var viewModel = StateViewModel()
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                StandardProgressView()
            case let .loaded(accounts):
                AccountsListView(accounts: accounts)
            case let .empty(message):
                StandardEmptyView(message: message)
            case let .error(message):
                StandardErrorView(message: message, retry: {
                    Task { await viewModel.load() }
                })
            }
        }
        .navigationTitle("Accounts")
        .onAppear {
            Task { await viewModel.load() }
        }
    }
}

#Preview {
    StateView()
}

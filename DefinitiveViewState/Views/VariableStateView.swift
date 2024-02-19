//
//  BasicStateView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

enum ViewState {
    case loading
    case loaded
    case empty
    case error
}

struct VariableStateView: View {
    @StateObject var viewModel = VariableStateViewModel()
    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .error:
                    StandardErrorView(message: viewModel.error, retry: {
                        Task { await viewModel.load() }
                    })
                case .empty:
                    StandardEmptyView(message: viewModel.empty)
                case .loading:
                    StandardProgressView()
                case .loaded:
                    AccountsListView(accounts: viewModel.accounts)
                }
            }
            .navigationTitle("Accounts")
            .onAppear {
                Task { await viewModel.load() }
            }
        }
    }
}

#Preview {
    VariableStateView()
}

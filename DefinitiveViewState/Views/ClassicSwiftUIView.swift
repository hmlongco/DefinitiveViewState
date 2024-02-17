//
//  ClassicSwiftUIView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

struct ClassicSwiftUIView: View {
    @StateObject var viewModel = ClassicSwiftUIViewModel()
    var body: some View {
        NavigationStack {
            Group {
                if let error = viewModel.error {
                    StandardErrorView(message: error, retry: {
                        Task { await viewModel.load() }
                    })
                } else if let empty = viewModel.empty {
                    StandardEmptyView(message: empty)
                } else if viewModel.loading {
                    StandardProgressView()
                } else {
                    AccountsListView(accounts: viewModel.accounts)
                }
            }
            .navigationTitle("Accounts")
            .onAppear() {
                Task { await viewModel.load() }
            }
        }
    }
}

#Preview {
    ClassicSwiftUIView()
}

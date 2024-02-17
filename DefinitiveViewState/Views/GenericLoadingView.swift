//
//  GenericLoadingView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

struct TestGenericLoadingView: View {
    var body: some View {
        NavigationStack {
            GenericLoadingView(loader: load, content: { accounts in
                AccountsListView(accounts: accounts)
            })
            .loadingProgressView {
                AccountsListView(accounts: AccountManager.mock)
                    .redacted(reason: .placeholder)
                    .shimmering()
            }
            .navigationTitle("Accounts")
        }
    }

    func load() async throws -> [Account] {
        try await AccountManager().load()
    }
}

struct GenericLoadingView<Content: View, Result>: View {

    @State private var state: GenericViewState<Result> = .loading

    private var loader: () async -> GenericViewState<Result>
    private var content: (Result) -> Content

    private var progressView: (() -> any View)?
    private var emptyView: ((String, @escaping () -> Void) -> any View)?
    private var errorView: ((String, @escaping () -> Void) -> any View)?

    init(loader: @escaping () async -> GenericViewState<Result>, @ViewBuilder content: @escaping (Result) -> Content) {
        self.content = content
        self.loader = loader
    }

    init(loader: @escaping () async throws -> Result, @ViewBuilder content: @escaping (Result) -> Content) {
        self.content = content
        self.loader = {
            do {
                return .loaded(try await loader())
            } catch {
                return .error(error.localizedDescription)
            }
        }
    }

    func loadingProgressView(@ViewBuilder content: @escaping () -> any View) -> Self {
        var copy: Self = self
        copy.progressView = content
        return copy
    }

    func loadingEmptyView(@ViewBuilder content: @escaping (String, @escaping () -> Void) -> any View) -> Self {
        var copy: Self = self
        copy.emptyView = content
        return copy
    }

    func loadingErrorView(@ViewBuilder content: @escaping (String, @escaping () -> Void) -> any View) -> Self {
        var copy: Self = self
        copy.errorView = content
        return copy
    }

    var body: some View {
        switch state {
        case .loading:
            Group {
                if let view: any View = progressView?() {
                    AnyView(view)
                } else {
                    StandardProgressView()
                }
            }
            .task {
                state = await loader()
            }
        case .loaded(let data):
            content(data)
        case .empty(let message):
            if let view: any View = emptyView?(message, { state = .loading }) {
                AnyView(view)
            } else {
                StandardEmptyView(message: message)
            }
        case .error(let message):
            if let view: any View = errorView?(message, { state = .loading }) {
                AnyView(view)
            } else {
                StandardErrorView(message: message) {
                    state = .loading
                }
            }
        }
    }

}

#Preview {
    TestGenericLoadingView()
}

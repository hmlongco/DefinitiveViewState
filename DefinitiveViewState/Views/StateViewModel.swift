//
//  StateViewModel.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

enum LoadingViewState<Result> {
    case loading
    case loaded(Result)
    case empty(String)
    case error(String)
}

class StateViewModel: ObservableObject {

    @Published var state: LoadingViewState<[Account]> = .loading

    let manager = AccountManager()

    @MainActor
    func load() async {
        do {
            let accounts = try await manager.load()
            if accounts.isEmpty {
                state = .empty("No accounts found")
            } else {
                state = .loaded(accounts)
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }

}

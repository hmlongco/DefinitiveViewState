//
//  VariableStateViewModel.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

class VariableStateViewModel: ObservableObject {

    @Published var state: ViewState = .loading
    @Published var accounts: [Account] = []
    @Published var empty: String = ""
    @Published var error: String = ""

    let manager = AccountManager()

    @MainActor
    func load() async {
        do {
            state = .loading
            accounts = try await manager.load()
            if accounts.isEmpty {
                empty = "No accounts found"
                state = .empty
            } else {
                state = .loaded
            }
        } catch {
            self.error = error.localizedDescription
            state = .error
        }
    }
}

//
//  ComputedStateViewModel.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

class ComputedStateViewModel: ObservableObject {

    var state: ViewState {
        if !error.isEmpty {
            return .error
        } else if !empty.isEmpty {
            return .empty
        } else if loading {
            return .loading
        } else {
            return .loaded
        }
    }

    @Published var accounts: [Account] = []
    @Published var loading: Bool = false
    @Published var empty: String = ""
    @Published var error: String = ""

    let manager = AccountManager()
    
    @MainActor
    func load() async {
        do {
            accounts = []
            empty = ""
            error = ""
            loading = true
            accounts = try await manager.load()
            if accounts.isEmpty {
                empty = "No accounts found"
            }
            loading = false
        } catch {
            self.error = error.localizedDescription
            loading = false
        }
    }
}

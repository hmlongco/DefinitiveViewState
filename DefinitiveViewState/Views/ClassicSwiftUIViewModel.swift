//
//  ClassicSwiftUIViewModel.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

class ClassicSwiftUIViewModel: ObservableObject {

    @Published var accounts: [Account] = []
    @Published var loading: Bool = false
    @Published var empty: String?
    @Published var error: String?

    let manager = AccountManager()
    
    @MainActor
    func load() async {
        do {
            accounts = []
            empty = nil
            error = nil
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

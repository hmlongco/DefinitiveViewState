//
//  AccountsListView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

struct AccountsListView: View {
    let accounts: [Account]
    var body: some View {
        List {
            ForEach(accounts) { account in
                NavigationLink(account.name, value: account)
            }
            .navigationDestination(for: Account.self) { account in
                Text("Details for \(account.name)")
            }
        }
    }
}

#Preview {
    AccountsListView(accounts: AccountManager.mock)
}

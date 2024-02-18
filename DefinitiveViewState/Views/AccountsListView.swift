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
        }
    }
}

#Preview {
    AccountsListView(accounts: AccountManager.mock)
}

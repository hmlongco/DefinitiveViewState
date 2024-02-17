//
//  AccountManager.swift
//  Navigator
//
//  Created by Long, Hoy on 9/25/23.
//

import Foundation

class AccountManager {
    
    static var shared: AccountManager = .init()
    
    var accounts: [Account] = []
    
    func load() async throws -> [Account] {
        try? await Task.sleep(nanoseconds: 750_000_000)
        accounts = Self.mock
        return accounts
    }

    func account(for id: String?) -> Account? {
        accounts.first(where: { $0.id == id })
    }

    static var mock: [Account] = [
        Account(id: "111", name: "Brokerage Account", type: "Personal", balance: 37612.22),
        Account(id: "222", name: "Traditional IRA", type: "Retirement", balance: 256782.72)
    ]

}

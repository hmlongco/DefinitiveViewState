//
//  Account.swift
//  DeepLinking
//
//  Created by Long, Hoy on 6/15/23.
//

import Foundation

struct Account: Identifiable, Hashable {
    var id: String
    var name: String
    var type: String
    var balance: Double
}

extension Account {
    static var formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currencyAccounting
        return f
    }()
    
    var formattedBalance: String {
        Self.formatter.string(for: balance) ?? "-"
    }
}

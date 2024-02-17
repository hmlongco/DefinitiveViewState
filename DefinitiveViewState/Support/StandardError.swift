//
//  StandardError.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

enum StandardError: Error, LocalizedError {
    case unknown
    var errorDescription: String? {
        "Unknown error occurred"
    }
}

//
//  AuthenticationView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/18/24.
//

import SwiftUI

struct Credentials {}
struct User {}

enum AuthenticationState {
    case unauthenticated
    case loginUsernamePassword
    case loginPasscode
    case loginBiometrics
    case authenticated(User)
    case logout(User)
    case blocked(String)
    case locked(String)
}

struct AuthenticationView: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    AuthenticationView()
}

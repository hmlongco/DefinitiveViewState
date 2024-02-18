//
//  ContentView.swift
//  DefinitiveViewState
//
//  Created by Michael Long on 2/17/24.
//

import SwiftUI

enum Destinations: Int {
    case classic
    case computed
    case variable
    case associated
    case shimmering
    case generic
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("Classic State View", value: Destinations.classic)
                NavigationLink("Computed State View", value: Destinations.computed)
                NavigationLink("Variable Loading View", value: Destinations.variable)
                NavigationLink("Associated State View", value: Destinations.associated)
                NavigationLink("Shimmering State View", value: Destinations.shimmering)
                NavigationLink("Generic Loading View", value: Destinations.generic)
            }
            .navigationDestination(for: Destinations.self) { d in
                switch d {
                case .classic:
                    ClassicSwiftUIView()
                case .computed:
                    ComputedStateView()
                case .variable:
                    VariableStateView()
                case .associated:
                    StateView()
                case .shimmering:
                    ShimmerStateView()
                case .generic:
                    SampleGenericLoadingView()
                }
           }
            .navigationDestination(for: Account.self) { account in
                Text("Details for \(account.name)")
            }
           .navigationTitle("ViewState")
        }
    }
}

#Preview {
    ContentView()
}

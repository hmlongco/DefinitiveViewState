//
//  Shimmer.swift
//  SwiftUI-Shimmer
//  Created by Vikram Kriplaney on 23.03.21.
//

import SwiftUI

/// A view modifier that applies an animated "shimmer" to any view, typically to show that an operation is in progress.
public struct Shimmer: ViewModifier {
    private let animation: Animation
    private let gradient: Gradient
    private let min, max: CGFloat
    @State private var isInitialState = true
    @Environment(\.layoutDirection) private var layoutDirection

    /// Initializes his modifier with a custom animation,
    /// - Parameters:
    ///   - animation: A custom animation. Defaults to ``Shimmer/defaultAnimation``.
    ///   - gradient: A custom gradient. Defaults to ``Shimmer/defaultGradient``.
    ///   - bandSize: The size of the animated mask's "band". Defaults to 0.3 unit points, which corresponds to
    /// 30% of the extent of the gradient.
    public init(
        animation: Animation = Self.defaultAnimation,
        gradient: Gradient = Self.defaultGradient,
        bandSize: CGFloat = 0.3
    ) {
        self.animation = animation
        self.gradient = gradient
        // Calculate unit point dimensions beyond the gradient's edges by the band size
        self.min = 0 - bandSize
        self.max = 1 + bandSize
    }

    /// The default animation effect.
    public static let defaultAnimation = Animation
        .linear(duration: 1.5)
        .delay(0.25)
        .repeatForever(autoreverses: false)

    // A default gradient for the animated mask.
    public static let defaultGradient = Gradient(colors: [
        .black.opacity(0.3), // translucent
        .black, // opaque
        .black.opacity(0.3) // translucent
    ])

    /// The start unit point of our gradient, adjusting for layout direction.
    var startPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: max, y: min) : UnitPoint(x: 0, y: 1)
        } else {
            return isInitialState ? UnitPoint(x: min, y: min) : UnitPoint(x: 1, y: 1)
        }
    }

    /// The end unit point of our gradient, adjusting for layout direction.
    var endPoint: UnitPoint {
        if layoutDirection == .rightToLeft {
            return isInitialState ? UnitPoint(x: 1, y: 0) : UnitPoint(x: min, y: max)
        } else {
            return isInitialState ? UnitPoint(x: 0, y: 0) : UnitPoint(x: max, y: max)
        }
    }

    public func body(content: Content) -> some View {
        content
            .mask(LinearGradient(gradient: gradient, startPoint: startPoint, endPoint: endPoint))
            .animation(animation, value: isInitialState)
            .onAppear {
                isInitialState = false
            }
    }
}

public extension View {
    /// Adds an animated shimmering effect to any view, typically to show that an operation is in progress.
    /// - Parameters:
    ///   - active: Convenience parameter to conditionally enable the effect. Defaults to `true`.
    ///   - animation: A custom animation. Defaults to ``Shimmer/defaultAnimation``.
    ///   - gradient: A custom gradient. Defaults to ``Shimmer/defaultGradient``.
    ///   - bandSize: The size of the animated mask's "band". Defaults to 0.3 unit points, which corresponds to
    /// 20% of the extent of the gradient.
    @ViewBuilder func shimmering(
        active: Bool = true,
        animation: Animation = Shimmer.defaultAnimation,
        gradient: Gradient = Shimmer.defaultGradient,
        bandSize: CGFloat = 0.3
    ) -> some View {
        if active {
            modifier(Shimmer(animation: animation, gradient: gradient, bandSize: bandSize))
        } else {
            self
        }
    }
}

#if DEBUG
struct Shimmer_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 50) {
            PreviewView()
            PreviewView()
                .redacted(reason: .placeholder)
            PreviewView()
                .redacted(reason: .placeholder)
                .shimmering()
        }
        .padding()
    }
}

struct PreviewView: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "star")
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text("SwiftUI Shimmer")
                    .font(.title)
                Text("This is some text that's going to shimmer across multiple lines.")
            }
        }
    }
}
#endif
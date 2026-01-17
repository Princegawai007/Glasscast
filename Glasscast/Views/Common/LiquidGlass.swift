//
//  LiquidGlass.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

// MARK: - Liquid Glass Design System
struct LiquidGlassModifier: ViewModifier {
    var cornerRadius: CGFloat
    
    // The "Clear" variant configuration
    func body(content: Content) -> some View {
        content
            .background {
                // 1. The Base Material (Refractive Layer)
                ZStack {
                    // Subtle surface tint for "thickness"
                    Color.white.opacity(0.03)
                    
                    // The Blur Effect
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark) // Force dark glass for your theme
                }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
                // Deep, soft shadow for elevation
                .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 10)
            }
            .overlay {
                // 2. Specular Highlight (The "Rim Light")
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .strokeBorder(
                        LinearGradient(
                            stops: [
                                .init(color: .white.opacity(0.5), location: 0),    // Bright top-left
                                .init(color: .white.opacity(0.1), location: 0.4),  // Fade out
                                .init(color: .white.opacity(0.05), location: 1)    // Subtle bottom-right
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                // Inner glow to simulate thickness
                    .padding(0.5)
            }
    }
}

// Replacement for your GlassEffectContainer
struct LiquidGlassContainer<Content: View>: View {
    var cornerRadius: CGFloat = 20
    @ViewBuilder var content: Content
    
    var body: some View {
        content
            .modifier(LiquidGlassModifier(cornerRadius: cornerRadius))
    }
}

extension View {
    func glassCircle() -> some View {
        self
            .background {
                Circle()
                    .fill(.ultraThinMaterial)
                    .environment(\.colorScheme, .dark)
                    .opacity(0.9)
            }
            .overlay {
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: [.white.opacity(0.4), .white.opacity(0.05)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            }
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

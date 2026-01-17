//
//  DesignSystem.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

// MARK: - 1. Color Palette (Stitch Exact Hex Codes)
extension Color {
    static let backgroundDark = Color(hex: "101622") // Deep Navy Background
    static let primaryBrand = Color(hex: "135bec")   // Electric Blue
    static let blobIndigo = Color(hex: "1e1b4b")     // Deep Indigo Glow
    static let blobPurple = Color(hex: "4c1d95")     // Vibrant Purple Glow
    
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

// MARK: - 2. Typography
extension Font {
    static func display(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        return .system(size: size, weight: weight, design: .rounded)
    }
}

// MARK: - 3. AppBackground (Fixed: Centered Lights)
struct AppBackground: View {
    var body: some View {
        ZStack {
            // Base Layer
            Color.backgroundDark.ignoresSafeArea()
            
            // Glows (Centered to shine through the glass)
            GeometryReader { proxy in
                ZStack {
                    // Main Indigo Glow
                    RadialGradient(
                        colors: [Color.blobIndigo, .clear],
                        center: UnitPoint(x: 0.5, y: 0.4),
                        startRadius: 0,
                        endRadius: proxy.size.width * 0.9
                    )
                    .opacity(1.0)
                    
                    // Secondary Blue Glow
                    RadialGradient(
                        colors: [Color.primaryBrand, .clear],
                        center: UnitPoint(x: 0.8, y: 0.8),
                        startRadius: 0,
                        endRadius: proxy.size.width * 0.8
                    )
                    .opacity(0.4)
                }
            }
            .blur(radius: 60)
            .ignoresSafeArea()
        }
    }
}
// MARK: - 4. Glass Effect Container
struct GlassEffectContainer<Content: View>: View {
    let content: Content
    let cornerRadius: CGFloat
    
    init(cornerRadius: CGFloat = 30, @ViewBuilder content: () -> Content) {
        self.cornerRadius = cornerRadius
        self.content = content()
    }
    
    var body: some View {
        content
            .background(
                ZStack {
                    // 1. The Blur (Forces Dark Mode)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .opacity(0.8)
                    
                    // 2. Subtle Gradient Border
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.2),
                                    Color.white.opacity(0.0)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                }
            )
            .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 10)
    }
}

// MARK: - 5. REQUIRED: Glass Circle Modifier (Fixes your error)
struct CircleGlassModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                ZStack {
                    Circle()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                    
                    Circle()
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                }
            )
    }
}

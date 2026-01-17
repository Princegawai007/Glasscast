//
//  DesignSystem.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import SwiftUI
//
//// MARK: - Color Extension
//extension Color {
//    static let primary = Color(hex: "135bec")
//    static let backgroundLight = Color(hex: "f6f6f8")
//    static let backgroundDark = Color(hex: "101622")
//    
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: // RGB (12-bit)
//            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: // RGB (24-bit)
//            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: // ARGB (32-bit)
//            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default:
//            (a, r, g, b) = (255, 0, 0, 0)
//        }
//        self.init(
//            .sRGB,
//            red: Double(r) / 255,
//            green: Double(g) / 255,
//            blue: Double(b) / 255,
//            opacity: Double(a) / 255
//        )
//    }
//}
//
//// MARK: - Typography
//extension Font {
//    static func display(size: CGFloat, weight: Font.Weight = .regular) -> Font {
//        return .system(size: size, weight: weight, design: .rounded)
//    }
//}
//
//// MARK: - AppBackground
//struct AppBackground: View {
//    var body: some View {
//        ZStack {
//            // Base dark background
//            Color.backgroundDark
//                .ignoresSafeArea()
//            
//            // Radial gradient blobs for liquid glass effect
//            ZStack {
//                // Top-left blob (indigo)
//                RadialGradient(
//                    gradient: Gradient(colors: [
//                        Color(hex: "1e1b4b").opacity(0.8),
//                        Color(hex: "1e1b4b").opacity(0.0)
//                    ]),
//                    center: .topLeading,
//                    startRadius: 0,
//                    endRadius: 400
//                )
//                
//                // Top-right blob (purple-indigo)
//                RadialGradient(
//                    gradient: Gradient(colors: [
//                        Color(hex: "312e81").opacity(0.8),
//                        Color(hex: "312e81").opacity(0.0)
//                    ]),
//                    center: .topTrailing,
//                    startRadius: 0,
//                    endRadius: 400
//                )
//                
//                // Bottom-right blob (blue)
//                RadialGradient(
//                    gradient: Gradient(colors: [
//                        Color(hex: "135bec").opacity(0.8),
//                        Color(hex: "135bec").opacity(0.0)
//                    ]),
//                    center: .bottomTrailing,
//                    startRadius: 0,
//                    endRadius: 400
//                )
//                
//                // Bottom-left blob (purple)
//                RadialGradient(
//                    gradient: Gradient(colors: [
//                        Color(hex: "4c1d95").opacity(0.8),
//                        Color(hex: "4c1d95").opacity(0.0)
//                    ]),
//                    center: .bottomLeading,
//                    startRadius: 0,
//                    endRadius: 400
//                )
//            }
//            .ignoresSafeArea()
//        }
//    }
//}
//
//// MARK: - GlassEffectContainer
//struct GlassEffectContainer<Content: View>: View {
//    let content: Content
//    let cornerRadius: CGFloat
//    
//    init(cornerRadius: CGFloat = 16, @ViewBuilder content: () -> Content) {
//        self.cornerRadius = cornerRadius
//        self.content = content()
//    }
//    
//    var body: some View {
//        content
//            .background(
//                ZStack {
//                    // Base background with opacity
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                        .fill(Color.white.opacity(0.05))
//                    
//                    // Ultra thin material for blur effect
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                        .fill(.ultraThinMaterial)
//                    
//                    // Inner glow (inset shadow effect)
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                        .strokeBorder(
//                            LinearGradient(
//                                gradient: Gradient(colors: [
//                                    Color.white.opacity(0.2),
//                                    Color.white.opacity(0.0)
//                                ]),
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            ),
//                            lineWidth: 1
//                        )
//                        .shadow(color: Color.white.opacity(0.05), radius: 20, x: 0, y: 0)
//                    
//                    // Border
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                        .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
//                }
//                .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
//            )
//    }
//}
//
//// MARK: - Glass Effect Modifier
//extension View {
//    func glassEffect() -> some View {
//        self.modifier(GlassEffectModifier())
//    }
//}
//
//struct GlassEffectModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .background(.ultraThinMaterial)
//            .background(Color.white.opacity(0.05))
//            .overlay(
//                RoundedRectangle(cornerRadius: 0)
//                    .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
//            )
//            .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
//    }
//}
//
//  DesignSystem.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//
//
//  DesignSystem.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//MARK: NEW EXACT REPLICA FILE FROM GEMINI

//
//  DesignSystem.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//
//  DesignSystem.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

//import SwiftUI
//
//// MARK: - 1. Color Palette (Stitch Exact Hex Codes)
//extension Color {
//    static let backgroundDark = Color(hex: "101622") // Deep Navy Background
//    static let primaryBrand = Color(hex: "135bec")   // Electric Blue
//    static let blobIndigo = Color(hex: "1e1b4b")     // Deep Indigo Glow
//    static let blobPurple = Color(hex: "4c1d95")     // Vibrant Purple Glow
//    
//    init(hex: String) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//        var int: UInt64 = 0
//        Scanner(string: hex).scanHexInt64(&int)
//        let a, r, g, b: UInt64
//        switch hex.count {
//        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//        default: (a, r, g, b) = (255, 0, 0, 0)
//        }
//        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
//    }
//}
//
//// MARK: - 2. Typography (Rounded Design)
//extension Font {
//    static func display(size: CGFloat, weight: Font.Weight = .regular) -> Font {
//        return .system(size: size, weight: weight, design: .rounded)
//    }
//}
//
//// MARK: - 3. The "Stitch" Background (Crucial Fix: Centered Lights)
//struct AppBackground: View {
//    var body: some View {
//        ZStack {
//            // 1. Base Dark Layer
//            Color.backgroundDark.ignoresSafeArea()
//            
//            // 2. The Glows (Moved to CENTER to shine through the glass card)
//            GeometryReader { proxy in
//                ZStack {
//                    // Main Indigo Glow (Behind the Temperature Card)
//                    RadialGradient(
//                        colors: [Color.blobIndigo, .clear],
//                        center: UnitPoint(x: 0.5, y: 0.4), // CENTERED
//                        startRadius: 0,
//                        endRadius: proxy.size.width * 0.9
//                    )
//                    .opacity(1.0)
//                    
//                    // Secondary Blue Glow (Bottom Right Accent)
//                    RadialGradient(
//                        colors: [Color.primaryBrand, .clear],
//                        center: UnitPoint(x: 0.8, y: 0.8),
//                        startRadius: 0,
//                        endRadius: proxy.size.width * 0.8
//                    )
//                    .opacity(0.4)
//                }
//            }
//            .blur(radius: 60) // Softens the lights
//            .ignoresSafeArea()
//        }
//    }
//}
//
//// MARK: - 4. The "Liquid Glass" Container
//struct GlassEffectContainer<Content: View>: View {
//    let content: Content
//    let cornerRadius: CGFloat
//    
//    init(cornerRadius: CGFloat = 30, @ViewBuilder content: () -> Content) {
//        self.cornerRadius = cornerRadius
//        self.content = content()
//    }
//    
//    var body: some View {
//        content
//            .background(
//                ZStack {
//                    // Layer 1: The Blur (Forces Dark Mode for "Smoked" look)
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                        .fill(.ultraThinMaterial)
//                        .environment(\.colorScheme, .light )
//                    
//                    // Layer 2: Subtle Gradient Border (Top-left light source)
//                    RoundedRectangle(cornerRadius: cornerRadius)
//                        .stroke(
//                            LinearGradient(
//                                colors: [
//                                    Color.white.opacity(0.2), // Top-left shine
//                                    Color.white.opacity(0.0)  // Bottom-right fade
//                                ],
//                                startPoint: .topLeading,
//                                endPoint: .bottomTrailing
//                            ),
//                            lineWidth: 1
//                        )
//                }
//            )
//            // Layer 3: Soft Drop Shadow for Depth
//            .shadow(color: Color.black.opacity(0.4), radius: 20, x: 0, y: 10)
//    }
//}
//
//// MARK: - 5. Modifier for Buttons (Circle Glass)
//struct CircleGlassModifier: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .background(
//                ZStack {
//                    Circle()
//                        .fill(.ultraThinMaterial)
//                        .environment(\.colorScheme, .light)
//                    
//                    Circle()
//                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
//                }
//            )
//    }
//}
//
//extension View {
//    func glassCircle() -> some View {
//        self.modifier(CircleGlassModifier())
//    }
//}
//
//  DesignSystem.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

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

// This is the function HomeView is looking for:
extension View {
    func glassCircle() -> some View {
        self.modifier(CircleGlassModifier())
    }
}

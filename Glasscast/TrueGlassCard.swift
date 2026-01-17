//
//  TrueGlassCard.swift
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

import SwiftUI

//struct TrueGlassCard<Content: View>: View {
//    let cornerRadius: CGFloat
//    let content: Content
//
//    init(cornerRadius: CGFloat = 24, @ViewBuilder content: () -> Content) {
//        self.cornerRadius = cornerRadius
//        self.content = content()
//    }
//
//    var body: some View {
//        content
//            .background {
//                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
//                    .fill(.ultraThinMaterial)
//                    .environment(\.colorScheme, .dark)
//            }
//            .overlay {
//                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
//                    .stroke(Color.white.opacity(0.12), lineWidth: 1)
//            }
//            .overlay {
//                RoundedRectangle(cornerRadius: cornerRadius)
//                    .stroke(
//                        LinearGradient(
//                            colors: [Color.white.opacity(0.18), .clear],
//                            startPoint: .top,
//                            endPoint: .bottom
//                        ),
//                        lineWidth: 1
//                    )
//            }
//            .shadow(color: .black.opacity(0.35), radius: 30, y: 18)
//            .compositingGroup()
//    }
//}

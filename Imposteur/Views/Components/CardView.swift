//
//  CardView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct CardView<Content: View>: View {
    let content: Content
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(18)
            .background(
                ZStack {
                    // soft blurred material
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(.ultraThinMaterial)

                    // gentle color overlay to match app theme
                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .fill(LinearGradient(
                            colors: [AppTheme.accentStart.opacity(0.12), AppTheme.accentEnd.opacity(0.10)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing))

                    RoundedRectangle(cornerRadius: 22, style: .continuous)
                        .stroke(Color.white.opacity(0.08), lineWidth: 1)
                }
            )
            .shadow(color: Color.black.opacity(0.55), radius: 26, x: 0, y: 14)
    }
}

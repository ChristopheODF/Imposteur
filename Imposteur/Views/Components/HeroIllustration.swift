//
//  HeroIllustration.swift
//  Imposteur
//
//  Created by GitHub Copilot on 07/05/2026.
//

import SwiftUI

struct HeroIllustration: View {
    @State private var float = false
    @State private var rotate = false

    var body: some View {
        ZStack {
            // Big soft gradient blob
            RoundedRectangle(cornerRadius: 120, style: .continuous)
                .fill(AppTheme.accentGradient)
                .frame(width: 520, height: 320)
                .rotationEffect(.degrees(rotate ? 8 : -8))
                .offset(x: rotate ? -30 : 20, y: float ? -8 : 8)
                .blur(radius: 30)
                .opacity(0.28)

            // Secondary blob for depth
            Circle()
                .fill(LinearGradient(colors: [AppTheme.accentEnd.opacity(0.9), AppTheme.accentStart.opacity(0.9)], startPoint: .top, endPoint: .bottom))
                .frame(width: 240, height: 240)
                .offset(x: 90, y: 10)
                .blendMode(.screen)
                .opacity(0.18)

            // Central emblem — simple abstract 'mask' that suggests a card/role
            ZStack {
                RoundedRectangle(cornerRadius: 28, style: .continuous)
                    .fill(Color.white.opacity(0.06))
                    .frame(width: 220, height: 140)
                    .shadow(color: Color.black.opacity(0.45), radius: 20, x: 0, y: 12)

                Image(systemName: "person.3.fill")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundStyle(AppTheme.accentGradient)
                    .offset(y: -6)

                VStack(spacing: 2) {
                    Text("Imposteur")
                        .font(.headline)
                        .foregroundStyle(AppTheme.subtleText)
                    Text("Rôles & indices")
                        .font(.caption)
                        .foregroundStyle(AppTheme.subtleText.opacity(0.9))
                }
                .offset(y: 42)
            }
            .scaleEffect(float ? 1.02 : 1)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 6).repeatForever(autoreverses: true)) {
                float.toggle()
            }
            withAnimation(.interpolatingSpring(stiffness: 30, damping: 6).delay(0.2)) {
                rotate.toggle()
            }
        }
    }
}

struct HeroIllustration_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [AppTheme.bgTop, AppTheme.bgBottom]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            HeroIllustration()
                .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}

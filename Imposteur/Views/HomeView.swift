//
//  HomeView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        ZStack {
            // animated background with subtle floating blobs
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [AppTheme.bgTop, AppTheme.bgBottom]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                // decorative soft blobs
                Circle()
                    .fill(AppTheme.accentGradient)
                    .frame(width: 360, height: 360)
                    .blur(radius: 40)
                    .offset(x: -90, y: -160)
                    .opacity(0.12)

                Circle()
                    .fill(AppTheme.accentGradient)
                    .frame(width: 260, height: 260)
                    .blur(radius: 32)
                    .offset(x: 110, y: -40)
                    .opacity(0.10)
            }

            VStack(spacing: 18) {
                Spacer(minLength: 8)

                // Hero illustration: large, animated and prominent
                HeroIllustration()
                    .frame(height: 320)
                    .padding(.horizontal, 12)

                // Title & subtitle grouped on top of hero area
                VStack(spacing: 6) {
                    AnimatedTitle()
                        .padding(.top, 6)

                    Text("Jeu de rôles cachés · Mots proches · Agent secret")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.subtleText)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 18)

                Spacer(minLength: 6)

                // CTAs in a more compact card
                CardView {
                    VStack(spacing: 12) {
                        PrimaryButton(title: "Nouvelle partie", systemImage: "play.fill", roleColor: AppTheme.accentStart) {
                            vm.openNewGame()
                        }
                        PrimaryButton(title: "Règles", systemImage: "book.fill", roleColor: AppTheme.accentEnd) {
                            vm.openRules()
                        }
                    }
                    .padding(.vertical, 8)
                }
                .padding(.horizontal, 24)

                Spacer(minLength: 10)

                Text("Passe le téléphone · Révèle ton rôle · Donne un indice · Vote")
                    .font(.footnote)
                    .foregroundStyle(AppTheme.subtleText.opacity(0.85))
                    .padding(.bottom, 8)
            }
            .padding(.vertical, 6)
        }
    }
}

struct AnimatedTitle: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            Text("Imposteur")
                .font(.system(size: 44, weight: .heavy, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [AppTheme.accentStart, AppTheme.accentEnd],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .scaleEffect(animate ? 1.02 : 1)
                .opacity(animate ? 1 : 0.96)
                .shadow(color: Color.black.opacity(0.35), radius: 16, x: 0, y: 8)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                animate.toggle()
            }
        }
    }
}

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
            LinearGradient(
                gradient: Gradient(colors: [AppTheme.bgTop, AppTheme.bgBottom]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {
                Spacer()

                VStack(spacing: 8) {
                    AnimatedTitle()

                    Text("Jeu de rôles cachés · Mots proches · Agent secret")
                        .font(.subheadline)
                        .foregroundStyle(AppTheme.subtleText)
                        .multilineTextAlignment(.center)
                }

                Spacer()

                CardView {
                    VStack(spacing: 14) {
                        PrimaryButton(title: "Nouvelle partie", systemImage: "play.fill", roleColor: AppTheme.accentStart) {
                            vm.openNewGame()
                        }
                        PrimaryButton(title: "Règles", systemImage: "book.fill", roleColor: AppTheme.accentEnd) {
                            vm.openRules()
                        }
                    }
                }
                .padding(.horizontal, 18)

                Spacer(minLength: 24)

                Text("Passe le téléphone · Révèle ton rôle · Donne un indice · Vote")
                    .font(.footnote)
                    .foregroundStyle(AppTheme.subtleText.opacity(0.85))
            }
            .padding(.vertical, 24)
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

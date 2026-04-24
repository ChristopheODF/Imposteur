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
        VStack(spacing: 18) {
            Spacer()

            VStack(spacing: 10) {
                Text("Imposteur")
                    .font(.system(size: 44, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)

                Text("Jeu de rôles cachés · Mots proches · Agent secret")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.75))
                    .multilineTextAlignment(.center)
            }

            Spacer()

            CardView {
                VStack(spacing: 12) {
                    PrimaryButton(title: "Nouvelle partie", systemImage: "play.fill") {
                        vm.openNewGame()
                    }
                    PrimaryButton(title: "Règles", systemImage: "book.fill", roleColor: .white.opacity(0.18)) {
                        vm.openRules()
                    }
                }
            }
            .padding(.horizontal, 18)

            Spacer(minLength: 24)

            Text("Passe le téléphone · Révèle ton rôle · Donne un indice · Vote")
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.55))
        }
        .padding(.vertical, 24)
    }
}

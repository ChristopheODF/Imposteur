//
//  GameOverView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        let winner = vm.state.winner ?? .imposteurs

        VStack(spacing: 14) {
            Spacer()

            Text("Partie terminée")
                .font(.system(size: 34, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)

            Text(winnerTitle(winner))
                .font(.system(size: 28, weight: .heavy, design: .rounded))
                .foregroundStyle(winnerColor(winner))

            CardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Mots")
                        .font(.headline)
                        .foregroundStyle(.white)

                    HStack {
                        Text("Équipiers :")
                            .foregroundStyle(.white.opacity(0.75))
                        Text(vm.state.wordEquipiers)
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                    HStack {
                        Text("Imposteurs :")
                            .foregroundStyle(.white.opacity(0.75))
                        Text(vm.state.wordImposteurs)
                            .foregroundStyle(.white)
                            .font(.headline)
                    }
                }
            }
            .padding(.horizontal, 18)

            CardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Rôles")
                        .font(.headline)
                        .foregroundStyle(.white)

                    ForEach(vm.state.players) { p in
                        HStack {
                            Text(p.displayName)
                                .foregroundStyle(.white)
                            Spacer()
                            Text(roleLabel(p.role))
                                .foregroundStyle(colorForRole(p.role))
                                .font(.subheadline.weight(.semibold))
                        }
                        Divider().overlay(Color.white.opacity(0.08))
                    }
                }
            }
            .padding(.horizontal, 18)

            CardView {
                VStack(spacing: 12) {
                    PrimaryButton(title: "Refaire une partie (mêmes joueurs)", systemImage: "repeat") {
                        vm.restartSameSettings()
                    }

                    PrimaryButton(title: "Nouvelle partie", systemImage: "arrow.clockwise") {
                        vm.openNewGame()
                    }

                    PrimaryButton(title: "Accueil", systemImage: "house.fill", roleColor: .white.opacity(0.18)) {
                        vm.goHome()
                    }
                }
            }
            .padding(.horizontal, 18)

            Spacer()
        }
        .padding(.vertical, 14)
    }

    private func winnerTitle(_ w: Winner) -> String {
        switch w {
        case .equipiers: return "Les Équipiers gagnent"
        case .imposteurs: return "Les Imposteurs gagnent"
        case .agentSecret: return "L’Agent secret gagne"
        }
    }

    private func winnerColor(_ w: Winner) -> Color {
        switch w {
        case .equipiers: return AppTheme.success
        case .imposteurs: return AppTheme.danger
        case .agentSecret: return AppTheme.warning
        }
    }

    private func roleLabel(_ r: Role) -> String {
        switch r {
        case .equipier: return "Équipier"
        case .imposteur: return "Imposteur"
        case .agentSecret: return "Agent secret"
        }
    }

    private func colorForRole(_ r: Role) -> Color {
        switch r {
        case .equipier: return AppTheme.success
        case .imposteur: return AppTheme.danger
        case .agentSecret: return AppTheme.warning
        }
    }
}

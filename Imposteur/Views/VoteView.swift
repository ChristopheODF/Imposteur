//
//  VoteView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct VoteView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        let alivePlayers = vm.state.players.filter { $0.isAlive }

        VStack(spacing: 14) {
            HStack {
                Text("Vote")
                    .font(.largeTitle.bold())
                    .foregroundStyle(AppTheme.accentGradient)
                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.top, 14)

            CardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Vote à main levée.")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text("Ensuite, sélectionne ici le joueur éliminé (validation).")
                        .foregroundStyle(.white.opacity(0.75))
                }
            }
            .padding(.horizontal, 18)

            CardView {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Joueur éliminé")
                        .font(.headline)
                        .foregroundStyle(.white)

                    ForEach(alivePlayers, id: \ .id) { p in
                        PlayerRowView(player: p, isSelected: vm.state.pendingEliminationPlayerID == p.id) {
                            vm.setPendingElimination(vm.state.pendingEliminationPlayerID == p.id ? nil : p.id)
                        }
                        Divider().overlay(Color.white.opacity(0.08))
                    }
                }
            }
            .padding(.horizontal, 18)

// Small helper subview to keep VoteView body simple for the compiler
struct PlayerRowView: View {
    let player: Player
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        HStack {
            Text(player.displayName)
                .foregroundStyle(.white)
                .font(.body)
            Spacer()
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(isSelected ? AppTheme.accentStart : .white.opacity(0.35))
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(isSelected ? AppTheme.accentGradient.opacity(0.12) : Color.clear)
        )
        .contentShape(Rectangle())
        .onTapGesture(perform: onTap)
    }
}

            CardView {
                VStack(spacing: 12) {
                    PrimaryButton(title: "Valider l’élimination", systemImage: "trash.fill", roleColor: AppTheme.danger,
                                  disabled: vm.state.pendingEliminationPlayerID == nil) {
                        vm.eliminateSelected()
                    }

                    PrimaryButton(title: "Retour au tour", systemImage: "chevron.left", roleColor: .white.opacity(0.18)) {
                        // autorise retour sans valider si besoin
                        vm.resumeRoundFromVote()
                    }
                }
            }
            .padding(.horizontal, 18)

            if let last = vm.state.lastEliminated {
                // Normalement on bascule phase immédiatement, mais on garde au cas où.
                Text("Dernier éliminé: \(last.displayName)")
                    .foregroundStyle(.white.opacity(0.6))
            }

            Spacer(minLength: 10)
        }
    }
}

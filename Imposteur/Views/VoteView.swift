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
                    .foregroundStyle(.white)
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

                    ForEach(alivePlayers) { p in
                        let selected = (vm.state.pendingEliminationPlayerID == p.id)
                        Button {
                            vm.setPendingElimination(selected ? nil : p.id)
                        } label: {
                            HStack {
                                Text(p.displayName)
                                    .foregroundStyle(.white)
                                Spacer()
                                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(selected ? AppTheme.accentStart : .white.opacity(0.35))
                            }
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(.plain)
                        Divider().overlay(Color.white.opacity(0.08))
                    }
                }
            }
            .padding(.horizontal, 18)

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

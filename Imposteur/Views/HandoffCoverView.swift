//
//  HandoffCoverView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct HandoffCoverView: View {
    @EnvironmentObject var vm: AppViewModel
    @State private var isRevealed = false

    // AJOUT: on fige le joueur révélé
    @State private var revealedPlayerID: UUID? = nil

    var body: some View {
        let idx = vm.state.currentRevealIndex
        let currentPlayer = vm.state.players[idx]

        // On récupère le "snapshot" (joueur figé) si révélée
        let revealedPlayer: Player? = {
            guard let id = revealedPlayerID else { return nil }
            return vm.state.players.first(where: { $0.id == id })
        }()

        VStack(spacing: 16) {
            Spacer()

            Text("Passe le téléphone")
                .font(.system(size: 34, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)

            Text(currentPlayer.displayName)
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white.opacity(0.85))

            CardView {
                VStack(spacing: 12) {
                    if !isRevealed {
                        Text("Appuie pour révéler ton rôle et ton mot.")
                            .foregroundStyle(.white.opacity(0.85))
                            .multilineTextAlignment(.center)

                        PrimaryButton(title: "Révéler", systemImage: "eye.fill") {
                            // Snapshot au moment du reveal
                            revealedPlayerID = currentPlayer.id
                            isRevealed = true
                        }

                        Text("Assure-toi que personne ne regarde.")
                            .font(.footnote)
                            .foregroundStyle(.white.opacity(0.65))
                    } else {
                        if let revealedPlayer {
                            RevealRoleView(player: revealedPlayer)
                        }

                        PrimaryButton(
                            title: "Cacher et passer",
                            systemImage: "hand.raised.fill",
                            roleColor: .white.opacity(0.18)
                        ) {
                            // On ferme la révélation (animation OK)
                            isRevealed = false

                            // On nettoie le snapshot un poil plus tard (après l’anim)
                            let oldID = revealedPlayerID
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                if revealedPlayerID == oldID { revealedPlayerID = nil }
                            }

                            // On passe au joueur suivant après l’animation
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                vm.advanceReveal()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 18)

            Spacer()
        }
        .padding(.vertical, 24)
        .animation(.spring(response: 0.35, dampingFraction: 0.85), value: isRevealed)
        .onChange(of: vm.state.currentRevealIndex) { _, _ in
            // sécurité: si l’index change pour une raison externe, on recache
            isRevealed = false
            revealedPlayerID = nil
        }
    }
}

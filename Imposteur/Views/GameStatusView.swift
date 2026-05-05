//
//  GameStatusView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct GameStatusView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        let counts = GameEngine.aliveCounts(state: vm.state)

        VStack(spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Tour \(vm.state.round)")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Text("Donnez vos indices, puis votez.")
                        .foregroundStyle(.white.opacity(0.75))
                }
                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.top, 14)

            CardView {
                VStack(spacing: 10) {
                    HStack {
                        PillBadge(text: "Équipiers: \(counts.equipiers)", color: AppTheme.success)
                        Spacer()
                        PillBadge(text: "Imposteurs: \(counts.imposteurs)", color: AppTheme.danger)
                    }
                    if vm.state.config.hasSecretAgent {
                        HStack {
                            PillBadge(text: "Agent secret: \(counts.agentSecret)", color: AppTheme.warning)
                            Spacer()
                        }
                    }
                    Text("Le mot n’est jamais affiché ici pour éviter les fuites.")
                        .font(.footnote)
                        .foregroundStyle(.white.opacity(0.65))
                }
            }
            .padding(.horizontal, 18)

            CardView {
                VStack(spacing: 12) {
                    PrimaryButton(title: "Lancer le vote", systemImage: "checkmark.seal.fill", roleColor: AppTheme.accentStart) {
                        vm.beginVote()
                    }
                    PrimaryButton(title: "Recommencer la partie", systemImage: "repeat") {
                        vm.restartSameSettings()
                    }
                    PrimaryButton(title: "Abandonner", systemImage: "xmark.circle.fill", roleColor: .white.opacity(0.18)) {
                        vm.goHome()
                    }
                }
            }
            .padding(.horizontal, 18)

            Spacer()
        }
    }
}

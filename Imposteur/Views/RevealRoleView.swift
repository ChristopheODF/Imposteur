//
//  RevealRoleView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct RevealRoleView: View {
    @EnvironmentObject var vm: AppViewModel
    let player: Player

    var body: some View {
        let info = GameEngine.roleAndWord(for: player, state: vm.state)

        VStack(spacing: 12) {
            Text(info.roleLabel)
                .font(.system(size: 30, weight: .heavy, design: .rounded))
                .foregroundStyle(colorForRole(player.role))

            Text(info.wordLabel)
                .font(.system(size: 42, weight: .heavy, design: .rounded))
                .foregroundStyle(.white)

            Text(wordHint(for: player.role))
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    private func colorForRole(_ role: Role) -> Color {
        switch role {
        case .equipier: return AppTheme.success
        case .imposteur: return AppTheme.danger
        case .agentSecret: return AppTheme.warning
        }
    }

    private func wordHint(for role: Role) -> String {
        switch role {
        case .equipier:
            return "Donne des indices sans révéler le mot."
        case .imposteur:
            return "Ton mot est proche. Mélange vérité et prudence."
        case .agentSecret:
            return "Tu n’as pas de mot. Observe et improvise."
        }
    }
}

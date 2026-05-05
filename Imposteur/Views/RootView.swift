//
//  RootView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        ZStack {
            LinearGradient(colors: [AppTheme.bgTop, AppTheme.bgBottom],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()

            switch vm.state.phase {
            case .home:
                HomeView()
            case .newGame:
                NewGameView()
            case .rules:
                RulesView()
            case .names:
                PlayerNamesView()
            case .distributing:
                HandoffCoverView()
            case .inGame:
                GameStatusView()
            case .voting:
                VoteView()
            case .secretAgentGuess:
                GuessWordView()
            case .gameOver:
                GameOverView()
            }
        }
        .tint(AppTheme.accentStart)
    }
}

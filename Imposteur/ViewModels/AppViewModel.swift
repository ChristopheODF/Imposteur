//
//  AppViewModel.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class AppViewModel: ObservableObject {
    @Published private(set) var state = GameState()
    @Published private(set) var lastUsedConfig: GameConfig? = nil
    @Published private(set) var lastUsedNames: [String]?
    @Published var draftNames: [String] = []
    
    func resumeRoundFromVote() {
        state.phase = .inGame
    }
    
    var turnTimerSelectionBinding: Binding<Int> {
        Binding(
            get: { self.state.config.turnTimerSeconds ?? 0 },
            set: { self.state.config.turnTimerSeconds = ($0 == 0 ? nil : $0) }
        )
    }
    
    var secretAgentGuessBinding: Binding<String> {
        Binding(
            get: { self.state.secretAgentGuessText },
            set: { self.state.secretAgentGuessText = $0 }
        )
    }

    func goHome() {
        state = GameState()
        state.phase = .home
    }

    func openNewGame() {
        state.phase = .newGame
        // preset par défaut (avec ta règle Agent secret à partir de 5)
        state.config.playerCount = max(6, GameConfig.minPlayers)
        state.config.hasSecretAgent = GameConfig.defaultHasSecretAgent(for: state.config.playerCount)
        state.config.impostorCount = GameConfig.defaultImpostors(for: state.config.playerCount)
        state.config.turnTimerSeconds = nil
    }

    func openRules() {
        state.phase = .rules
    }

    func startGame() {
        let cfg = GameEngine.validatedConfig(state.config)
        
        // sauvegarde pour "refaire une partie"
        lastUsedConfig = cfg
        lastUsedNames = state.playerNames // on va ajouter ça au state plus bas
        
        state = GameEngine.startNewGame(config: cfg, names: lastUsedNames)
    }

    func advanceReveal() {
        if state.currentRevealIndex + 1 >= state.players.count {
            state.phase = .inGame
        } else {
            state.currentRevealIndex += 1
        }
    }

    func beginVote() {
        GameEngine.beginVote(state: &state)
    }

    func eliminateSelected() {
        guard let id = state.pendingEliminationPlayerID else { return }
        GameEngine.eliminate(playerID: id, state: &state)
    }

    func submitSecretAgentGuess() {
        GameEngine.submitSecretAgentGuess(state: &state)
    }

    func setPendingElimination(_ id: UUID?) {
        state.pendingEliminationPlayerID = id
    }

    func applyPlayerCount(_ n: Int) {
        state.config.playerCount = min(max(n, GameConfig.minPlayers), GameConfig.maxPlayers)

        // règle: agent secret 1 à partir de 5 joueurs sinon 0
        if state.config.playerCount < 5 {
            state.config.hasSecretAgent = false
        } else if state.config.hasSecretAgent == false {
            // on ne force pas à true, on laisse le toggle, mais preset à l'écran new game
        }

        // ajuste bornes imposteurs
        let maxImp = state.config.maxImpostorsAllowed()
        state.config.impostorCount = min(max(state.config.impostorCount, 1), maxImp)
    }

    func applyImpostorCount(_ n: Int) {
        let maxImp = state.config.maxImpostorsAllowed()
        state.config.impostorCount = min(max(n, 1), maxImp)
    }

    func applyHasSecretAgent(_ on: Bool) {
        if state.config.playerCount < 5 {
            state.config.hasSecretAgent = false
        } else {
            state.config.hasSecretAgent = on
        }
        let maxImp = state.config.maxImpostorsAllowed()
        state.config.impostorCount = min(max(state.config.impostorCount, 1), maxImp)
    }
    
    func startGameFromNames() {
        let cfg = GameEngine.validatedConfig(state.config)

        lastUsedConfig = cfg
        lastUsedNames = draftNames

        state = GameEngine.startNewGame(config: cfg, names: draftNames)
    }

    func restartSameSettings() {
        guard let cfg = lastUsedConfig else {
            // fallback: si aucune partie n'a été lancée encore
            openNewGame()
            return
        }
        state = GameEngine.startNewGame(config: cfg, names: lastUsedNames)
    }
    
    func openNames() {
        let n = state.config.playerCount

        // Si on a déjà des noms saisis, on les garde; sinon on pré-remplit (optionnel) avec les derniers noms
        let base = Array(repeating: "", count: n)

        if draftNames.count == n {
            // ok
        } else if let last = lastUsedNames, last.count >= n {
            draftNames = Array(last.prefix(n))
        } else if state.playerNames.count == n {
            draftNames = state.playerNames
        } else {
            draftNames = base
        }

        state.phase = .names
    }
    
    func setPlayerName(_ name: String, at index: Int) {
        guard state.playerNames.indices.contains(index) else { return }
        state.playerNames[index] = name
    }
    
    func backToNewGame() { state.phase = .newGame }
}

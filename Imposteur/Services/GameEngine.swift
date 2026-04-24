//
//  GameEngine.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import Foundation

enum GameEngine {

    static func startNewGame(config: GameConfig, names: [String]? = nil) -> GameState {
        var state = GameState()
        state.config = validatedConfig(config)
        state.phase = .distributing
        state.round = 1
        state.currentRevealIndex = 0

        let safeNames = normalizedNames(names, count: state.config.playerCount)
        state.players = makePlayers(config: state.config, names: safeNames)

        if let pair = WordBank.shared.randomPair() {
            state.wordEquipiers = pair.a
            state.wordImposteurs = pair.b
        } else {
            state.wordEquipiers = "chat"
            state.wordImposteurs = "tigre"
        }

        return state
    }

    static func makePlayers(config: GameConfig, names: [String]) -> [Player] {
        let n = config.playerCount
        let impostors = config.impostorCount
        let secretAgents = config.hasSecretAgent ? 1 : 0
        let equipiers = n - impostors - secretAgents

        var roles: [Role] = []
        roles.append(contentsOf: Array(repeating: .equipier, count: equipiers))
        roles.append(contentsOf: Array(repeating: .imposteur, count: impostors))
        roles.append(contentsOf: Array(repeating: .agentSecret, count: secretAgents))
        roles.shuffle()

        return (1...n).enumerated().map { (offset, idx) in
            Player(index: idx, role: roles[offset], name: names[offset])
        }
    }

    static func normalizedNames(_ names: [String]?, count: Int) -> [String] {
        let base = (1...count).map { "Joueur \($0)" }
        guard let names else { return base }

        var out: [String] = []
        out.reserveCapacity(count)

        for i in 0..<count {
            let raw = i < names.count ? names[i] : ""
            let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            out.append(trimmed.isEmpty ? base[i] : trimmed)
        }
        return out
    }

    static func validatedConfig(_ config: GameConfig) -> GameConfig {
        var c = config
        c.playerCount = min(max(c.playerCount, GameConfig.minPlayers), GameConfig.maxPlayers)
        c.hasSecretAgent = (c.playerCount >= 5) ? c.hasSecretAgent : false

        let maxImpostors = c.maxImpostorsAllowed()
        c.impostorCount = min(max(c.impostorCount, 1), maxImpostors)
        return c
    }

    static func makePlayers(config: GameConfig) -> [Player] {
        let n = config.playerCount
        let impostors = config.impostorCount
        let secretAgents = config.hasSecretAgent ? 1 : 0
        let equipiers = n - impostors - secretAgents

        var roles: [Role] = []
        roles.append(contentsOf: Array(repeating: .equipier, count: equipiers))
        roles.append(contentsOf: Array(repeating: .imposteur, count: impostors))
        roles.append(contentsOf: Array(repeating: .agentSecret, count: secretAgents))
        roles.shuffle()

        return (1...n).enumerated().map { (offset, idx) in
            Player(index: idx, role: roles[offset])
        }
    }

    static func roleAndWord(for player: Player, state: GameState) -> (roleLabel: String, wordLabel: String) {
        switch player.role {
        case .equipier:
            return ("Équipier", state.wordEquipiers)
        case .imposteur:
            return ("Imposteur", state.wordImposteurs)
        case .agentSecret:
            return ("Agent secret", "Aucun mot")
        }
    }

    static func aliveCounts(state: GameState) -> (equipiers: Int, imposteurs: Int, agentSecret: Int) {
        let alive = state.players.filter { $0.isAlive }
        let e = alive.filter { $0.role == .equipier }.count
        let i = alive.filter { $0.role == .imposteur }.count
        let a = alive.filter { $0.role == .agentSecret }.count
        return (e, i, a)
    }

    static func canEquipiersStillWin(state: GameState) -> Bool {
        let c = aliveCounts(state: state)
        // si imposteurs >= équipiers, les équipiers ne peuvent plus gagner
        return c.imposteurs < c.equipiers
    }

    static func checkWinnerIfAny(state: GameState) -> Winner? {
        let c = aliveCounts(state: state)

        // Undercover/imposteurs gagnent dès que les équipiers ne peuvent plus gagner
        if c.imposteurs >= c.equipiers && (c.imposteurs > 0) {
            return .imposteurs
        }

        // Équipiers gagnent si tous les imposteurs éliminés ET pas d'agent secret vivant
        if c.imposteurs == 0 && c.agentSecret == 0 {
            return .equipiers
        }

        return nil
    }

    static func beginVote(state: inout GameState) {
        state.phase = .voting
        state.pendingEliminationPlayerID = nil
        state.lastEliminated = nil
    }

    static func eliminate(playerID: UUID, state: inout GameState) {
        guard let idx = state.players.firstIndex(where: { $0.id == playerID }) else { return }
        guard state.players[idx].isAlive else { return }

        state.players[idx].isAlive = false
        state.lastEliminated = state.players[idx]
        state.pendingEliminationPlayerID = nil

        // Si agent secret éliminé -> phase devinette
        if state.lastEliminated?.role == .agentSecret {
            state.phase = .secretAgentGuess
            state.secretAgentGuessText = ""
            return
        }

        // Sinon, on vérifie la victoire immédiate
        if let w = checkWinnerIfAny(state: state) {
            state.winner = w
            state.phase = .gameOver
            return
        }

        // Si les équipiers ne peuvent plus gagner, on stoppe aussi
        if !canEquipiersStillWin(state: state) {
            state.winner = .imposteurs
            state.phase = .gameOver
            return
        }

        // Round suivant
        state.round += 1
        state.phase = .inGame
    }

    static func submitSecretAgentGuess(state: inout GameState) {
        let guess = normalized(state.secretAgentGuessText)
        let target = normalized(state.wordEquipiers)

        if guess == target {
            state.winner = .agentSecret
            state.phase = .gameOver
            return
        }

        // Sinon on continue, mais l'agent secret est déjà éliminé.
        if let w = checkWinnerIfAny(state: state) {
            state.winner = w
            state.phase = .gameOver
            return
        }

        if !canEquipiersStillWin(state: state) {
            state.winner = .imposteurs
            state.phase = .gameOver
            return
        }

        state.round += 1
        state.phase = .inGame
    }

    static func normalized(_ s: String) -> String {
        s.trimmingCharacters(in: .whitespacesAndNewlines)
            .folding(options: [.diacriticInsensitive, .caseInsensitive], locale: .current)
    }
}

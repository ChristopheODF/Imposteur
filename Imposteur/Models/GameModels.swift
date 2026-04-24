//
//  GameModels.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import Foundation

enum Role: String, Codable, CaseIterable {
    case equipier
    case imposteur
    case agentSecret
}

struct Player: Identifiable, Codable, Equatable {
    let id: UUID
    let index: Int
    var isAlive: Bool
    var role: Role
    var name: String
    
    init(index: Int, role: Role, name: String? = nil) {
        self.id = UUID()
        self.index = index
        self.isAlive = true
        self.role = role
        self.name = (name?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false) ? name! : "Joueur \(index)"
    }
    
    var displayName: String { name }
}

enum GamePhase: String, Codable {
    case home
    case newGame
    case rules
    case names
    case distributing
    case inGame
    case voting
    case secretAgentGuess
    case gameOver
}

enum Winner: String, Codable {
    case equipiers
    case imposteurs
    case agentSecret
}

struct GameState: Codable, Equatable {
    var phase: GamePhase = .home

    var config = GameConfig()
    var players: [Player] = []
    
    var playerNames: [String] = []

    var currentRevealIndex: Int = 0
    var wordEquipiers: String = ""
    var wordImposteurs: String = ""
    var round: Int = 1

    var pendingEliminationPlayerID: UUID? = nil
    var lastEliminated: Player? = nil

    var secretAgentGuessText: String = ""
    var winner: Winner? = nil
}

//
//  GameConfig.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import Foundation

struct GameConfig: Equatable, Codable {
    var playerCount: Int = 6
    var impostorCount: Int = 1
    var hasSecretAgent: Bool = true
    /// Timer optionnel par tour (phase de discussion). nil = off
    var turnTimerSeconds: Int? = nil

    static let minPlayers = 4
    static let maxPlayers = 20

    static func defaultImpostors(for players: Int) -> Int {
        max(1, players / 6) // arrondi inf
    }

    static func defaultHasSecretAgent(for players: Int) -> Bool {
        players >= 5
    }

    func maxImpostorsAllowed() -> Int {
        // Il faut toujours au moins 2 équipiers au départ pour que le jeu ait un sens.
        let reservedForOthers = (hasSecretAgent ? 1 : 0)
        return max(1, playerCount - reservedForOthers - 2)
    }
}

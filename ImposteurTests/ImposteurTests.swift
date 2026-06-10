//
//  ImposteurTests.swift
//  ImposteurTests
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import Testing
@testable import Imposteur

struct ImposteurTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    // Vérifie que le premier joueur n'est jamais Agent secret sur 200 parties (hasSecretAgent=true).
    @Test func firstPlayerIsNeverSecretAgent() async throws {
        var config = GameConfig()
        config.playerCount = 6
        config.impostorCount = 1
        config.hasSecretAgent = true

        for _ in 0..<200 {
            let players = GameEngine.makePlayers(config: config, names: GameEngine.normalizedNames(nil, count: config.playerCount))
            #expect(players.first?.role != .agentSecret, "Le premier joueur ne doit pas être Agent secret")
        }
    }

    // Vérifie la régression : sans Agent secret, la distribution reste fonctionnelle.
    @Test func noSecretAgentDistributionIsUnchanged() async throws {
        var config = GameConfig()
        config.playerCount = 5
        config.impostorCount = 1
        config.hasSecretAgent = false

        for _ in 0..<200 {
            let players = GameEngine.makePlayers(config: config, names: GameEngine.normalizedNames(nil, count: config.playerCount))
            #expect(players.count == config.playerCount)
            #expect(!players.contains(where: { $0.role == .agentSecret }))
        }
    }

    @Test func showRoleDuringDistributionDefaultsToTrueAndIsCodable() async throws {
        let config = GameConfig()

        #expect(config.showRoleDuringDistribution)

        let data = try JSONEncoder().encode(config)
        let decoded = try JSONDecoder().decode(GameConfig.self, from: data)

        #expect(decoded == config)
        #expect(decoded.showRoleDuringDistribution)
    }

    @Test func validatedConfigPreservesShowRoleDuringDistribution() async throws {
        var config = GameConfig()
        config.playerCount = 6
        config.impostorCount = 1
        config.hasSecretAgent = true
        config.showRoleDuringDistribution = false

        let validated = GameEngine.validatedConfig(config)

        #expect(!validated.showRoleDuringDistribution)
    }

}

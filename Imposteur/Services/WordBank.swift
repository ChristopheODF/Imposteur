//
//  WordBank.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import Foundation

final class WordBank {
    static let shared = WordBank()

    private(set) var pairs: [WordPair] = []

    private init() { }

    func loadIfNeeded() {
        guard pairs.isEmpty else { return }

        guard let url = Bundle.main.url(forResource: "word_pairs_fr", withExtension: "json") else {
            assertionFailure("word_pairs_fr.json introuvable dans le bundle.")
            pairs = []
            return
        }
        do {
            let data = try Data(contentsOf: url)
            pairs = try JSONDecoder().decode([WordPair].self, from: data)
        } catch {
            assertionFailure("Erreur de chargement des mots: \(error)")
            pairs = []
        }
    }

    func randomPair() -> WordPair? {
        loadIfNeeded()
        return pairs.randomElement()
    }
}

//
//  WordPair.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import Foundation

struct WordPair: Codable, Equatable, Hashable {
    let a: String // mot équipiers
    let b: String // mot imposteurs
    let category: String
}

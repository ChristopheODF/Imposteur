//
//  AppTheme.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

enum AppTheme {
    // Primary accents (gradient pair)
    static let accentStart = Color(red: 0.56, green: 0.21, blue: 0.95) // vivid violet
    static let accentEnd = Color(red: 0.14, green: 0.79, blue: 0.80) // teal

    // Background gradient
    static let bgTop = Color(red: 0.05, green: 0.06, blue: 0.12)
    static let bgBottom = Color(red: 0.02, green: 0.02, blue: 0.04)

    // Semantic colors
    static let danger = Color(red: 0.92, green: 0.23, blue: 0.29)
    static let success = Color(red: 0.18, green: 0.80, blue: 0.44)
    static let warning = Color(red: 0.98, green: 0.74, blue: 0.22)

    // Subtle UI palette
    static let cardOverlay = Color.white.opacity(0.06)
    static let subtleText = Color.white.opacity(0.75)
}

extension AppTheme {
    // Compatibility alias for older usages
    static var accent: Color { accentStart }

    // Full gradient for heavy backgrounds / buttons
    static var accentGradient: LinearGradient {
        LinearGradient(colors: [accentStart, accentEnd], startPoint: .topLeading, endPoint: .bottomTrailing)
    }

    // Slightly stronger overlay used for highlighted cards
    static var cardOverlayStrong: Color { Color.white.opacity(0.10) }
}

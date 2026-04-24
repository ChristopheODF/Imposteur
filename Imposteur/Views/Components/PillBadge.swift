//
//  PillBadge.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct PillBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.subheadline.weight(.semibold))
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule().fill(color.opacity(0.18))
            )
            .overlay(
                Capsule().stroke(color.opacity(0.4), lineWidth: 1)
            )
            .foregroundStyle(color)
    }
}

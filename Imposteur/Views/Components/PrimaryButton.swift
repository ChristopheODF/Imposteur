//
//  PrimaryButton.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    var systemImage: String? = nil
    var roleColor: Color = AppTheme.accent
    var disabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(roleColor.opacity(disabled ? 0.35 : 0.95))
            )
        }
        .disabled(disabled)
        .foregroundStyle(.white)
    }
}

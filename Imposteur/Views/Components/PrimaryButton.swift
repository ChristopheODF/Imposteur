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
    var roleColor: Color = AppTheme.accentStart
    var disabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .imageScale(.medium)
                }
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
        }
        .buttonStyle(PrimaryButtonStyle(roleColor: roleColor, disabled: disabled))
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    var roleColor: Color
    var disabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(
                            colors: [roleColor, roleColor.opacity(0.9)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .scaleEffect(configuration.isPressed ? 0.985 : 1)
            .opacity(disabled ? 0.6 : 1)
            .foregroundStyle(.white)
            .shadow(color: Color.black.opacity(configuration.isPressed ? 0.12 : 0.24), radius: configuration.isPressed ? 6 : 12, x: 0, y: configuration.isPressed ? 3 : 8)
            .animation(.spring(response: 0.28, dampingFraction: 0.78, blendDuration: 0), value: configuration.isPressed)
    }
}

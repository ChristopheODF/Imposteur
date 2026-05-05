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
            .padding(.horizontal, 6)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(
                        LinearGradient(colors: [roleColor, roleColor.opacity(0.95)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .shadow(color: roleColor.opacity(0.22), radius: configuration.isPressed ? 6 : 14, x: 0, y: configuration.isPressed ? 2 : 10)
            )
            .scaleEffect(configuration.isPressed ? 0.975 : 1)
            .opacity(disabled ? 0.6 : 1)
            .foregroundStyle(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .stroke(Color.white.opacity(0.06), lineWidth: 1)
            )
            .animation(.interactiveSpring(response: 0.28, dampingFraction: 0.78, blendDuration: 0), value: configuration.isPressed)
    }
}

//
//  GuessWordView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct GuessWordView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        VStack(spacing: 14) {
            HStack {
                Text("Agent secret")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding(.horizontal, 18)
            .padding(.top, 14)

            CardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Tu as été éliminé.")
                        .font(.headline)
                        .foregroundStyle(.white)

                    Text("Tu peux gagner si tu devines le mot des Équipiers.")
                        .foregroundStyle(.white.opacity(0.8))
                }
            }
            .padding(.horizontal, 18)

            CardView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ta proposition")
                        .font(.headline)
                        .foregroundStyle(.white)

                    TextField("Entre le mot…", text: vm.secretAgentGuessBinding)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .padding(12)
                        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.08)))
                        .foregroundStyle(.white)

                    PrimaryButton(title: "Valider", systemImage: "sparkles", roleColor: AppTheme.warning,
                                  disabled: vm.state.secretAgentGuessText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
                        vm.submitSecretAgentGuess()
                    }
                }
            }
            .padding(.horizontal, 18)

            Spacer()
        }
    }
}

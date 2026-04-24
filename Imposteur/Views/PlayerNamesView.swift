//
//  PlayerNamesView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct PlayerNamesView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                HStack {
                    Text("Noms des joueurs")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Spacer()
                }

                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Optionnel : tu peux laisser vide.")
                            .foregroundStyle(.white.opacity(0.75))

                        ForEach(0..<vm.state.config.playerCount, id: \.self) { i in
                            TextField("Joueur \(i+1)", text: $vm.draftNames[i])
                                .textInputAutocapitalization(.words)
                                .disableAutocorrection(true)
                                .padding(12)
                                .background(RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.08)))
                                .foregroundStyle(.white)
                        }
                    }
                }

                CardView {
                    VStack(spacing: 12) {
                        PrimaryButton(title: "Lancer la distribution", systemImage: "hand.raised.fill") {
                            vm.startGameFromNames()
                        }

                        PrimaryButton(title: "Retour", systemImage: "chevron.left", roleColor: .white.opacity(0.18)) {
                            vm.backToNewGame()
                        }
                    }
                }
            }
            .padding(18)
        }
    }
}

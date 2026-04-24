//
//  RulesView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct RulesView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    Text("Règles")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                    Spacer()
                }

                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Rôles")
                            .font(.headline)
                            .foregroundStyle(.white)

                        Text("• Équipiers : même mot.\n• Imposteurs : mot proche.\n• Agent secret : aucun mot (il improvise).")
                            .foregroundStyle(.white.opacity(0.85))
                    }
                }

                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Déroulé")
                            .font(.headline)
                            .foregroundStyle(.white)

                        Text("À chaque tour, chacun donne un indice. Ensuite vote à main levée, puis on sélectionne sur le téléphone le joueur éliminé.")
                            .foregroundStyle(.white.opacity(0.85))
                    }
                }

                CardView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Victoire")
                            .font(.headline)
                            .foregroundStyle(.white)

                        Text("• Les Imposteurs gagnent si les Équipiers ne peuvent plus gagner (Imposteurs ≥ Équipiers).\n• Les Équipiers gagnent si tous les Imposteurs sont éliminés et qu’il n’y a plus d’Agent secret.\n• L’Agent secret gagne s’il est éliminé et qu’il devine le mot des Équipiers.")
                            .foregroundStyle(.white.opacity(0.85))
                    }
                }

                PrimaryButton(title: "Retour", systemImage: "chevron.left", roleColor: .white.opacity(0.18)) {
                    vm.goHome()
                }
                .padding(.top, 10)
            }
            .padding(18)
        }
    }
}

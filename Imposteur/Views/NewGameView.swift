//
//  NewGameView.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

struct NewGameView: View {
    @EnvironmentObject var vm: AppViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                HStack {
                    Text("Nouvelle partie")
                        .font(.largeTitle.bold())
                        .foregroundStyle(AppTheme.accentGradient)
                    Spacer()
                }

                CardView {
                    VStack(alignment: .leading, spacing: 14) {

                        HStack {
                            Text("Joueurs")
                                .foregroundStyle(AppTheme.accentGradient)
                                .font(.headline)
                            Spacer()
                            PillBadge(text: "\(vm.state.config.playerCount)", color: .white)
                        }

                        Stepper(value: Binding(
                            get: { vm.state.config.playerCount },
                            set: { vm.applyPlayerCount($0) }
                        ), in: GameConfig.minPlayers...GameConfig.maxPlayers) {
                            Text("Nombre de joueurs (4–20)")
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .tint(AppTheme.accentStart)

                        Divider().overlay(Color.white.opacity(0.1))

                        HStack {
                            Text("Imposteurs")
                                .foregroundStyle(AppTheme.danger)
                                .font(.headline)
                            Spacer()
                            PillBadge(text: "\(vm.state.config.impostorCount)", color: AppTheme.danger)
                        }

                        Stepper(value: Binding(
                            get: { vm.state.config.impostorCount },
                            set: { vm.applyImpostorCount($0) }
                        ), in: 1...vm.state.config.maxImpostorsAllowed()) {
                            Text("Nombre d’Imposteurs")
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .tint(AppTheme.danger)

                        Divider().overlay(Color.white.opacity(0.1))

                        Toggle(isOn: Binding(
                            get: { vm.state.config.hasSecretAgent },
                            set: { vm.applyHasSecretAgent($0) }
                        )) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Agent secret")
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text("1 à partir de 5 joueurs (sinon désactivé)")
                                    .foregroundStyle(.white.opacity(0.65))
                                    .font(.footnote)
                            }
                        }
                        .tint(AppTheme.warning)
                        .disabled(vm.state.config.playerCount < 5)

                        Divider().overlay(Color.white.opacity(0.1))

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Timer de discussion (optionnel)")
                                .foregroundStyle(AppTheme.subtleText)
                                .font(.headline)

                            Picker("Timer", selection: vm.turnTimerSelectionBinding) {
                                Text("Off").tag(0)
                                Text("30s").tag(30)
                                Text("60s").tag(60)
                                Text("90s").tag(90)
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                }

                CardView {
                    VStack(spacing: 12) {
                        PrimaryButton(title: "Continuer", systemImage: "person.2.fill") {
                            vm.openNames()
                        }

                        PrimaryButton(title: "Retour", systemImage: "chevron.left", roleColor: .white.opacity(0.18)) {
                            vm.goHome()
                        }
                    }
                }
            }
            .padding(18)
        }
    }
}

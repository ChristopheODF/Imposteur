//
//  ImposteurApp.swift
//  Imposteur
//
//  Created by Christophe Gaudout on 24/04/2026.
//

import SwiftUI

@main
struct ImposteurApp: App {
    @StateObject private var vm = AppViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(vm)
        }
    }
}

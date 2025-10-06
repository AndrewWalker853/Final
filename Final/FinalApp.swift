//
//  FinalApp.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI

@main
struct FinalApp: App {
    @StateObject private var store = GameStore()
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                showSplash = false
                            }
                        }
                    }
            } else {
                ContentView()
                    .environmentObject(store)
            }
        }
    }
}

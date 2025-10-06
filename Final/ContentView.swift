//
//  ContentView.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: GameStore
    @State private var showAchievements = false
    @State private var showUpgrades = false
    @State private var imageScale: CGFloat = 1.0

    var body: some View {
        VStack(spacing: 30) {
            // Score view
            ScoreView()
                .environmentObject(store)

            // Tappable gem image
            Image(
                store.autoClickLevel == 0 ? "ClickImage" :
                store.autoClickLevel == 1 ? "ClickImageLevel1" :
                store.autoClickLevel == 2 ? "ClickImageLevel2" :
                store.autoClickLevel == 3 ? "ClickImageLevel3" :
                store.autoClickLevel == 4 ? "ClickImageLevel4" :
                "ClickImageLevel5"
                )
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
                .scaleEffect(imageScale)
                .onTapGesture {
                    store.click()
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        imageScale = 1.2
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring()) {
                            imageScale = 1.0
                        }
                    }
                }

            
            if let powerUp = store.activePowerUp {
                Text("Active Power-Up: \(powerUp.name) x\(powerUp.multiplier)")
                    .foregroundColor(Color.appButtonBackground)
                    .padding(5)
                    .frame(maxWidth: .infinity)
                    .background(Color.appSecondaryBackground.opacity(0.7))
                    .cornerRadius(8)
            }

            
            HStack(spacing: 20) {
                Button(action: {
                    store.activatePowerUp(.doubleClick)
                }) {
                    Text("Double Click x2")
                        .padding(8)
                        .background(Color.appButtonBackground)
                        .foregroundColor(Color.appTextForeground)
                        .cornerRadius(8)
                }

                Button(action: {
                    store.activatePowerUp(.tripleClick)
                }) {
                    Text("Triple Click x3")
                        .padding(8)
                        .background(Color.appButtonBackground)
                        .foregroundColor(Color.appTextForeground)
                        .cornerRadius(8)
                }
            }

            
            Button(action: {
                showUpgrades.toggle()
            }) {
                Text("Upgrades")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(
                            colors: [Color.appScoreBackground.opacity(0.9),
                                     Color.appSecondaryBackground.opacity(0.8)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .foregroundColor(Color.appTextForeground)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            .sheet(isPresented: $showUpgrades) {
                UpgradesView()
                    .environmentObject(store)
            }

           
            AchievementButtonView(showAchievements: $showAchievements)
                .sheet(isPresented: $showAchievements) {
                    AchievementModal()
                        .environmentObject(store)
                }

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                colors: [Color.appPrimaryBackground, Color.appSecondaryBackground],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GameStore())
    }
}

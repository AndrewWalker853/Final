//
//  UpgradesView.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI

struct UpgradesView: View {
    @EnvironmentObject var store: GameStore
    private let maxLevel = 5 // visual list

    var body: some View {
        VStack(spacing: 16) {
            Text("Upgrades")
                .font(.title2)
                .bold()
                .padding(.top)

            Text("Auto-clicker: each level increases automatic clicks per second.")
                .font(.subheadline)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            List {
                ForEach(1...maxLevel, id: \.self) { level in
                    let unlocked = store.autoClickLevel >= level
                    let isNext = level == (store.autoClickLevel + 1)

                    UpgradeRow(
                        title: "Level \(level)",
                        subtitle: "\(level) click\(level == 1 ? "" : "s") / sec",
                        cost: isNext ? store.autoClickCost : nil,
                        unlocked: unlocked,
                        canPurchase: isNext && store.score >= store.autoClickCost
                    ) {
                        // Buy action: call the public API on GameStore
                        store.purchaseAutoClickUpgrade()
                    }
                }
            }
            .listStyle(.insetGrouped)

            Spacer()
        }
        .padding(.horizontal)
        .background(
            LinearGradient(
                colors: [Color.appPrimaryBackground, Color.appSecondaryBackground],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

struct UpgradeRow: View {
    let title: String
    let subtitle: String
    let cost: Int?          
    let unlocked: Bool
    let canPurchase: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline).foregroundColor(.secondary)
            }

            Spacer()

            if unlocked {
                Label("Owned", systemImage: "checkmark.seal.fill")
                    .foregroundColor(Color.green)
            } else if let cost = cost {
                Button(action: action) {
                    HStack(spacing: 8) {
                        Text("\(cost)")
                            .bold()
                        Text("Buy")
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color.appButtonBackground)
                    .foregroundColor(Color.appTextForeground)
                    .cornerRadius(8)
                }
                .disabled(!canPurchase)
                .opacity(canPurchase ? 1.0 : 0.6)
            } else {
                Text("Locked").foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 6)
    }
}

struct UpgradesView_Previews: PreviewProvider {
    static var previews: some View {
        UpgradesView()
            .environmentObject({
                let s = GameStore()
                s.autoClickLevel = 0
                s.score = 200
                return s
            }())
    }
}

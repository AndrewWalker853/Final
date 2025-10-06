//
//  ScoreView.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var store: GameStore

    var body: some View {
        VStack(spacing: 15) {
            Text("Score: \(store.score)")
                .font(.title)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [Color.appScoreBackground.opacity(0.8), Color.appSecondaryBackground.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .foregroundColor(Color.appTextForeground)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)

            ProgressView(value: store.progressToNextAchievement())
                .accentColor(Color.appButtonBackground)
                .padding()
                .background(Color.appSecondaryBackground.opacity(0.5))
                .cornerRadius(12)
        }
        .padding(.horizontal)
    }
}

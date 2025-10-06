//
//  AchievementButtonView.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI

struct AchievementButtonView: View {
    @Binding var showAchievements: Bool

    var body: some View {
        Button(action: {
            showAchievements.toggle()
        }) {
            Text("Achievements")
                .font(.title3)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [
                            Color.appScoreBackground.opacity(0.8),
                            Color.appSecondaryBackground.opacity(0.8)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .foregroundColor(Color.appTextForeground)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
        }
        .padding(.horizontal)
    }
}

struct AchievementButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementButtonView(showAchievements: .constant(false))
            .preferredColorScheme(.dark)
    }
}

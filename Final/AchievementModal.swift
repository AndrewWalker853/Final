//
//  AchievementModal.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI

struct AchievementModal: View {
    @EnvironmentObject var store: GameStore
    
    var body: some View {
        NavigationStack {
            List(store.achievements) { achievement in
                HStack {
                    VStack(alignment: .leading) {
                        Text(achievement.title)
                            .font(.headline)
                            .foregroundColor(.appTextForeground)
                        Text(achievement.description)
                            .font(.subheadline)
                            .foregroundColor(.appTextForeground)
                    }
                    Spacer()
                    if achievement.unlocked {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.appButtonBackground)
                    }
                }
                .padding(.vertical, 4)
                .listRowBackground(Color.appSecondaryBackground)
            }
            .navigationTitle("Achievements")
            .background(Color.appPrimaryBackground.ignoresSafeArea())
        }
    }
}

struct AchievementModal_Previews: PreviewProvider {
    static var previews: some View {
        AchievementModal()
            .environmentObject(GameStore())
    }
}

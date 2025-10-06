//
//  GameStore.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI
import Combine

class GameStore: ObservableObject {
    @Published var score: Int = 0
    @Published var clicks: Int = 0
    @Published var achievements: [Achievement] = Achievement.sampleAchievements
    @Published var activePowerUp: PowerUp?
    @Published var autoClickLevel: Int = 0
    @Published var autoClickCost: Int = 50

    private var powerUpTimer: AnyCancellable?
    private var autoClickTimer: AnyCancellable?
    private let saveKey = "FinalGameSave"

    init() {
        loadGame()
        startAutoClicker()
    }

    
    func click() {
        let multiplier = activePowerUp?.multiplier ?? 1
        clicks += 1
        score += multiplier

        checkAchievementsAfterClick()
        saveGame()
    }

    
    func activatePowerUp(_ powerUp: PowerUp, duration: TimeInterval = 15) {
        powerUpTimer?.cancel()
        activePowerUp = powerUp
        unlockNonNumericAchievement(.powerPlayer)

        powerUpTimer = Timer.publish(every: duration, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.activePowerUp = nil
                self?.powerUpTimer?.cancel()
            }
    }

   
    func purchaseAutoClickUpgrade() {
        guard score >= autoClickCost else { return }

        score -= autoClickCost
        autoClickLevel += 1

        // cost scaling: increase each level
        autoClickCost = Int(Double(autoClickCost) * 2.5)

        startAutoClicker()
        saveGame()
    }

    private func startAutoClicker() {
        autoClickTimer?.cancel()
        guard autoClickLevel > 0 else { return }

        // Each level adds 1 click per second
        autoClickTimer = Timer.publish(every: 1.0 / Double(autoClickLevel), on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.click()
            }
    }

   
    private func checkAchievementsAfterClick() {
        for i in 0..<achievements.count {
            guard !achievements[i].unlocked else { continue }

            if achievements[i].isNumeric {
                let value = achievements[i].criteriaUsesScore ? score : clicks
                if achievements[i].criteria(value) {
                    achievements[i].unlocked = true
                }
            }
        }
    }

    private func unlockNonNumericAchievement(_ achievementType: AchievementType) {
        if let index = achievements.firstIndex(where: { $0.type == achievementType && !$0.unlocked }) {
            achievements[index].unlocked = true
        }
    }

    
    func progressToNextAchievement() -> Double {
        let numericAchievements = achievements
            .filter { $0.isNumeric }
            .sorted { $0.criteriaThreshold() < $1.criteriaThreshold() }

        guard let next = numericAchievements.first(where: { !$0.unlocked }) else { return 1.0 }

        let previousThreshold = numericAchievements.last(where: { $0.unlocked })?.criteriaThreshold() ?? 0
        let currentValue = next.criteriaUsesScore ? score : clicks
        let progress = currentValue - previousThreshold
        let range = next.criteriaThreshold() - previousThreshold
        return max(0, min(Double(progress) / Double(range), 1.0))
    }

    
    func saveGame() {
        let state = GameState(
            score: score,
            clicks: clicks,
            achievementStatus: achievements.map { $0.unlocked },
            autoClickLevel: autoClickLevel,
            autoClickCost: autoClickCost
        )
        if let data = try? JSONEncoder().encode(state) {
            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                .appendingPathComponent("\(saveKey).json")
            try? data.write(to: url)
        }
    }

    func loadGame() {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("\(saveKey).json")
        if let data = try? Data(contentsOf: url),
           let state = try? JSONDecoder().decode(GameState.self, from: data) {
            self.score = state.score
            self.clicks = state.clicks
            self.autoClickLevel = state.autoClickLevel
            self.autoClickCost = state.autoClickCost
            for i in 0..<achievements.count {
                achievements[i].unlocked = state.achievementStatus[i]
            }
            startAutoClicker()
        }
    }
}


struct GameState: Codable {
    let score: Int
    let clicks: Int
    let achievementStatus: [Bool]
    let autoClickLevel: Int
    let autoClickCost: Int
}

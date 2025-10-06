//
//  Achievements.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import Foundation

enum AchievementType {
    case firstClick, gettingWarm, clickMaster, clickFrenzy, score500, score1000, powerPlayer
}

struct Achievement: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    var unlocked: Bool = false
    let criteria: (Int) -> Bool
    let isNumeric: Bool
    let criteriaUsesScore: Bool
    let type: AchievementType

    // achievements
    static let sampleAchievements: [Achievement] = [
        Achievement(title: "First Click", description: "Click the gem once", criteria: { $0 >= 1 }, isNumeric: true, criteriaUsesScore: false, type: .firstClick),
        Achievement(title: "Getting Warm", description: "Reach 50 clicks", criteria: { $0 >= 50 }, isNumeric: true, criteriaUsesScore: false, type: .gettingWarm),
        Achievement(title: "Click Master", description: "Reach 100 clicks", criteria: { $0 >= 100 }, isNumeric: true, criteriaUsesScore: false, type: .clickMaster),
        Achievement(title: "Click Frenzy", description: "Reach 200 clicks", criteria: { $0 >= 200 }, isNumeric: true, criteriaUsesScore: false, type: .clickFrenzy),
        Achievement(title: "Score Milestone: 500", description: "Reach a total score of 500", criteria: { $0 >= 500 }, isNumeric: true, criteriaUsesScore: true, type: .score500),
        Achievement(title: "Score Milestone: 1000", description: "Reach a total score of 1000", criteria: { $0 >= 1000 }, isNumeric: true, criteriaUsesScore: true, type: .score1000),
        Achievement(title: "Power Player", description: "Activate a power-up", criteria: { _ in true }, isNumeric: false, criteriaUsesScore: false, type: .powerPlayer),
    ]

    // Threshold for numeric achievements
    func criteriaThreshold() -> Int {
        switch type {
        case .firstClick: return 1
        case .gettingWarm: return 50
        case .clickMaster: return 100
        case .clickFrenzy: return 200
        case .score500: return 500
        case .score1000: return 1000
        default: return 1
        }
    }
}

//
//  PowerUps.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import Foundation

struct PowerUp: Codable {
    let name: String
    let multiplier: Int
}

extension PowerUp {
    static let doubleClick = PowerUp(name: "Double Click", multiplier: 2)
    static let tripleClick = PowerUp(name: "Triple Click", multiplier: 3)
}

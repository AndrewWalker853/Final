//
//  PrimaryButtonStyle.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.appButtonBackground)
            .foregroundColor(Color.appTextForeground)
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

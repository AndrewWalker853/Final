//
//  SplashScreen.swift
//  Final
//
//  Created by Andrew Walker on 10/5/25.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0

    var body: some View {
        ZStack {
            Color.appPrimaryBackground
                .ignoresSafeArea()
            
            Text("Gem Clicker")
                .font(.system(size: 64, weight: .bold))
                .foregroundColor(.appButtonBackground) 
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.spring(response: 1.0, dampingFraction: 0.5)) {
                        scale = 1
                        opacity = 1
                    }
                }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

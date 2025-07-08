//
//  SplashView.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/21/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var dateHolder: DateHolder
    @EnvironmentObject var exerciseStorage: ExerciseStorage

    @State private var isActive = false
    @State private var scale: CGFloat = 0.8
    @State private var opacity = 0.5

    var body: some View {
        ZStack {
            if isActive {
                OpeningView()
                    .transition(.opacity)
                    .environmentObject(dateHolder)
                    .environmentObject(exerciseStorage)
            } else {
                VStack {
                    Image(systemName: "figure.core.training")
                        .font(.system(size: 80))
                        .foregroundColor(.red)
                    Text("GymBuddy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        scale = 1.0
                        opacity = 1.0
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(DateHolder())
        .environmentObject(ExerciseStorage())
}

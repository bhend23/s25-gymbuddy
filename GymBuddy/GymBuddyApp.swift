//
//  GymBuddyApp.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/15/25.
//

import SwiftUI

@main
struct GymBuddyApp: App {
    @StateObject var dateHolder = DateHolder()
    @StateObject var exerciseStorage = ExerciseStorage()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(dateHolder)
                .environmentObject(exerciseStorage)
                .tint(.red)
        }
    }
}

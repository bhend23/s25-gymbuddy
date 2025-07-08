//
//  ExerciseStorage.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/18/25.
//

import Foundation

class ExerciseStorage: ObservableObject {
    static let shared = ExerciseStorage()
    @Published var exercisesByDate: [Date: [Exercise]] = [:]

    func save(_ exercises: [Exercise], for date: Date) {
        let key = Calendar.current.startOfDay(for: date)
        var current = exercisesByDate[key] ?? []
        for exercise in exercises {
            if !current.contains(where: { $0.name == exercise.name }) {
                current.append(exercise)
            }
        }
        exercisesByDate[key] = current
    }

    func get(for date: Date) -> [Exercise] {
        exercisesByDate[Calendar.current.startOfDay(for: date)] ?? []
    }

    func count(for date: Date) -> Int {
        get(for: date).count
    }

    func remove(at offsets: IndexSet, for date: Date) {
        let key = Calendar.current.startOfDay(for: date)
        guard var workouts = exercisesByDate[key] else { return }
        workouts.remove(atOffsets: offsets)
        exercisesByDate[key] = workouts
    }
}

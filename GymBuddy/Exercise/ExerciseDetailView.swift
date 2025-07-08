//
//  ExerciseDetailView.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/18/25.
//

import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise
    let date: Date
    @EnvironmentObject var storage: ExerciseStorage

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(exercise.name.capitalized)
                .font(.title)
                .bold()

            Text("Type: \(exercise.type.capitalized)")
            Text("Muscle: \(exercise.muscle.capitalized)")
            Text("Difficulty: \(exercise.difficulty.capitalized)")
            Text("Equipment: \(exercise.equipment.capitalized)")

            Text("Instructions:")
                .bold()

            ScrollView {
                Text(exercise.instructions)
            }

            Spacer()

            Button("Add to \(formatted(date))") {
                storage.save([exercise], for: date)
            }
            .buttonStyle(.borderedProminent)
            .padding(.top)
        }
        .padding()
    }

    func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


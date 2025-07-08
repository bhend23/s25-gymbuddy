//
//  WorkoutSummaryView.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/20/25.
//

import SwiftUI

struct WorkoutSummaryView: View {
    let date: Date
    @EnvironmentObject var storage: ExerciseStorage
    @State private var showPicker = false

    var body: some View {
        NavigationStack {
            VStack {
                if storage.get(for: date).isEmpty {
                    Text("No workouts saved for \(formatted(date - 1))")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(storage.get(for: date), id: \.name) { workout in
                            NavigationLink(destination: ExerciseDetailView(exercise: workout, date: date)) {
                                Text(workout.name)
                                    .fontWeight(.bold)
                                    .foregroundColor(.red)
                            }
                        }
                        .onDelete { indexSet in
                            storage.remove(at: indexSet, for: date)
                        }
                    }
                }

                Button("Add More Workouts") {
                    showPicker = true
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Workouts on \(formatted(date - 1))")
            .sheet(isPresented: $showPicker) {
                ExerciseByMuscleView(date: date)
                    .environmentObject(storage)
            }
        }
    }

    func formatted(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        return f.string(from: date)
    }
}

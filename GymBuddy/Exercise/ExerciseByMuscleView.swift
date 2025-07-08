//
//  ExerciseByMuscleView.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/18/25.
//
import SwiftUI

struct ExerciseByMuscleView: View {
    @EnvironmentObject var storage: ExerciseStorage
    @State private var selectedMuscle = "biceps"
    @State private var exercises: [Exercise] = []
    @State private var selectedExercise: Exercise? = nil
    @State private var isLoading = false
    @State private var errorMessage: String?

    let date: Date
    let muscles = [
        "abdominals", "abductors", "adductors", "biceps", "calves", "chest", "forearms",
        "glutes", "hamstrings", "lats", "lower_back", "middle_back", "neck", "quadriceps", "traps", "triceps"
    ]

    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Muscle", selection: $selectedMuscle) {
                    ForEach(muscles, id: \.self) {
                        Text($0.capitalized)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding()

                Button("Search Exercises") {
                    fetchExercises()
                }
                .buttonStyle(.borderedProminent)
                .padding()

                if isLoading {
                    ProgressView("Loading...")
                        .padding()
                }

                if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }

                if exercises.isEmpty && !isLoading && errorMessage == nil {
                    Text("No exercises found.")
                        .foregroundColor(.gray)
                        .padding()
                }

                if !exercises.isEmpty {
                    List(exercises) { exercise in
                        Button(action: {
                            selectedExercise = exercise
                        }) {
                            VStack(alignment: .leading) {
                                Text(exercise.name)
                                    .font(.headline)
                                Text("Type: \(exercise.type.capitalized), Difficulty: \(exercise.difficulty.capitalized)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Choose Muscle Group:")
            .sheet(item: $selectedExercise) { exercise in
                ExerciseDetailView(exercise: exercise, date: date)
                    .environmentObject(storage)
            }
        }
    }

    func fetchExercises() {
        isLoading = true
        errorMessage = nil
        exercises = []

        print("Fetching exercises for: \(selectedMuscle)")

        ExerciseService.shared.fetchExercisesByMuscle(muscle: selectedMuscle) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedExercises):
                    print("Fetched \(fetchedExercises.count) exercises.")
                    exercises = fetchedExercises
                case .failure(let error):
                    print("Error fetching: \(error.localizedDescription)")
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

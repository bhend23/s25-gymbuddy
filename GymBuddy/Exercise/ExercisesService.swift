//
//  ExercisesService.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/15/25.
//
import Foundation

class ExerciseService {
    static let shared = ExerciseService()

    private let baseURL = "https://api.api-ninjas.com/v1/exercises"
    private let apiKey = "oMmKfhRw7gKPy9ni175ehw==algy3Y8388MtYJfq"

    func fetchExercisesByMuscle(muscle: String, completion: @escaping (Result<[Exercise], Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)?muscle=\(muscle)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Network error: \(error)")
                completion(.failure(error))
                return
            }

            guard let data = data else {
                print("No data returned")
                completion(.failure(NetworkError.noData))
                return
            }

            print("RAW JSON:")
            if let jsonString = String(data: data, encoding: .utf8) {
                print(jsonString)
            } else {
                print("Invalid UTF-8 data")
            }

            do {
                let exercises = try JSONDecoder().decode([Exercise].self, from: data)
                completion(.success(exercises))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
}

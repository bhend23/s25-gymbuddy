//
//  ExercisesDecoding.swift
//  GymBuddy
//
//  Created by Brandon Henderson on 4/15/25.
//

struct Exercise: Decodable, Identifiable {
    var id: String { name }
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
}

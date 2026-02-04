//
//  ExerciseCatalog.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import Foundation

enum WorkoutCategory: String, CaseIterable, Identifiable {
    case push = "Push"
    case pull = "Pull"
    case legs = "Legs"
    case chest = "Chest"
    case back = "Back"
    case arms = "Arms"

    var id: String { rawValue }
}

struct ExerciseCatalog {
    static let exercises: [WorkoutCategory: [String]] = [
        .push: ["Bench Press", "Overhead Press", "Incline Bench", "Other"],
        .pull: ["Lat Pulldown", "Pull-Up", "Seated Row", "Other"],
        .legs: ["Squat", "Leg Press", "Romanian Deadlift", "Other"],
        .chest: ["Bench Press", "Dumbbell Fly", "Other"],
        .back: ["Deadlift", "Lat Pulldown", "Other"],
        .arms: ["Bicep Curl", "Tricep Pushdown", "Other"]
    ]
}

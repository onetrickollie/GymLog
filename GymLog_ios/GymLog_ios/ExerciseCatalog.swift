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
        .push: [
          "Barbell Bench Press",
          "Overhead Shoulder Press",
          "Incline Dumbbell Press",
          "Chest Fly",
          "Lateral Raises",
          "Dips",
          "Triceps Pushdown",
          "Skull Crushers",
          "Overhead Triceps Extension"
        ],
        .pull: [
          "Pull-Ups / Assisted Pull-Ups",
          "Lat Pulldown",
          "Barbell Row",
          "Seated Cable Row",
          "Face Pulls",
          "Rear Delt Fly",
          "Barbell Curl",
          "Hammer Curl"
        ],
        .legs: [
          "Back Squat",
          "Leg Press",
          "Romanian Deadlift",
          "Walking Lunges",
          "Leg Curl",
          "Leg Extension",
          "Standing Calf Raises",
          "Seated Calf Raises"
        ],
        .chest: ["Bench Press", "Dumbbell Fly", "Other"],
        .back: ["Deadlift", "Lat Pulldown", "Other"],
        .arms: ["Bicep Curl", "Tricep Pushdown", "Other"]
    ]
}

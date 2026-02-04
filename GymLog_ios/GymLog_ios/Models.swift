//
//  Models.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import Foundation
import SwiftData

@Model
final class Workout {
    var date: Date
    var notes: String
    var category: String

    // Starts when first set is added OR when user taps Start
    var startedAt: Date?
    // Set when user taps End Workout
    var endedAt: Date?

    @Relationship(deleteRule: .cascade, inverse: \ExerciseEntry.workout)
    var entries: [ExerciseEntry] = []

    init(date: Date = .now, notes: String = "", category: WorkoutCategory) {
        self.date = date
        self.notes = notes
        self.category = category.rawValue
        self.startedAt = nil
        self.endedAt = nil
    }
}


@Model
final class ExerciseEntry {
    var name: String
    var category: String
    var workout: Workout?

    @Relationship(deleteRule: .cascade)
    var sets: [WorkoutSet] = []

    init(name: String, category: WorkoutCategory, workout: Workout? = nil) {
        self.name = name
        self.category = category.rawValue
        self.workout = workout
    }
}

@Model
final class WorkoutSet {
    var weight: Double
    var reps: Int

    init(weight: Double, reps: Int) {
        self.weight = weight
        self.reps = reps
    }
}

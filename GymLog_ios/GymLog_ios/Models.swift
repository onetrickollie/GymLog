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

    // Relationship: one workout has many entries
    @Relationship(deleteRule: .cascade)
    var entries: [ExerciseEntry] = []

    init(date: Date = .now, notes: String = "") {
        self.date = date
        self.notes = notes
    }
}

@Model
final class ExerciseEntry {
    var name: String

    // Relationship: one entry has many sets
    @Relationship(deleteRule: .cascade)
    var sets: [WorkoutSet] = []

    init(name: String) {
        self.name = name
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

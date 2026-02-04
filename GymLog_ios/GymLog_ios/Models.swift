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

    @Relationship(deleteRule: .cascade)
    var entries: [ExerciseEntry] = []

    init(
        date: Date = .now,
        notes: String = "",
        category: WorkoutCategory
    ) {
        self.date = date
        self.notes = notes
        self.category = category.rawValue
    }
}


@Model
final class ExerciseEntry {
    var name: String
    var category: String

    // Relationship: one entry has many sets
    @Relationship(deleteRule: .cascade)
    var sets: [WorkoutSet] = []

    init(name: String,category: WorkoutCategory) {
        self.name = name
        self.category = category.rawValue
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

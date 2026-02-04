//
//  StatsHelper.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import Foundation

struct ExerciseStats {

    // Best this week = max (weight × reps)
    static func bestSetThisWeek(
        workouts: [Workout],
        exerciseName: String
    ) -> WorkoutSet? {

        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())!.start

        return workouts
            .filter { $0.date >= startOfWeek }
            .flatMap { $0.entries }
            .filter { $0.name == exerciseName }
            .flatMap { $0.sets }
            .max(by: volumeCompare)
    }

    // Personal Best = highest weight ever
    static func personalBest(
        workouts: [Workout],
        exerciseName: String
    ) -> WorkoutSet? {

        workouts
            .flatMap { $0.entries }
            .filter { $0.name == exerciseName }
            .flatMap { $0.sets }
            .max(by: { $0.weight < $1.weight })
    }

    private static func volumeCompare(_ a: WorkoutSet, _ b: WorkoutSet) -> Bool {
        a.weight * Double(a.reps) < b.weight * Double(b.reps)
    }
}

//
//  BestLiftsView.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/4/26.
//

import SwiftUI
import SwiftData

struct BestLiftsView: View {
    let workouts: [Workout]

    var body: some View {
        NavigationStack {
            List {
                if allExerciseNames().isEmpty {
                    ContentUnavailableView(
                        "No lifts yet",
                        systemImage: "trophy",
                        description: Text("Log some sets to see your weekly bests and PRs.")
                    )
                } else {
                    ForEach(WorkoutCategory.allCases) { category in
                        let exercises = exercisesFor(category: category)

                        if !exercises.isEmpty {
                            Section(category.rawValue) {
                                ForEach(exercises, id: \.self) { name in
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(name)
                                            .font(.headline)

                                        if let weekly = ExerciseStats.bestSetThisWeek(
                                            workouts: workouts,
                                            exerciseName: name
                                        ) {
                                            Text("Best This Week: \(weekly.weight, specifier: "%.0f") lbs × \(weekly.reps)")
                                                .foregroundStyle(.secondary)
                                        } else {
                                            Text("Best This Week: —")
                                                .foregroundStyle(.secondary)
                                        }

                                        if let pr = ExerciseStats.personalBest(
                                            workouts: workouts,
                                            exerciseName: name
                                        ) {
                                            Text("Personal Best: \(pr.weight, specifier: "%.0f") lbs")
                                                .font(.caption)
                                                .foregroundStyle(.green)
                                        } else {
                                            Text("Personal Best: —")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    .padding(.vertical, 4)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Best Lifts")
        }
    }

    private func allExerciseNames() -> [String] {
        Set(workouts.flatMap { $0.entries.map { $0.name } }).sorted()
    }

    private func exercisesFor(category: WorkoutCategory) -> [String] {
        var names = Set<String>()
        for workout in workouts {
            for entry in workout.entries {
                // entry.category is a String like "Push", "Pull", etc.
                if entry.category == category.rawValue {
                    names.insert(entry.name)
                }
            }
        }
        return Array(names).sorted()
    }
}

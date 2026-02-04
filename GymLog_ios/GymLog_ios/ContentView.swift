//
//  ContentView.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Workout.date, order: .reverse) private var workouts: [Workout]

    @State private var showingAddWorkout = false

    var body: some View {
        NavigationStack {
            Section("Best Lifts") {
                ForEach(uniqueExerciseNames(), id: \.self) { name in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(name)
                            .font(.headline)

                        if let weekly = ExerciseStats.bestSetThisWeek(
                            workouts: workouts,
                            exerciseName: name
                        ) {
                            Text("Best This Week: \(weekly.weight, specifier: "%.0f") lbs × \(weekly.reps)")
                                .foregroundStyle(.secondary)
                        }

                        if let pr = ExerciseStats.personalBest(
                            workouts: workouts,
                            exerciseName: name
                        ) {
                            Text("Personal Best: \(pr.weight, specifier: "%.0f") lbs")
                                .font(.caption)
                                .foregroundStyle(.green)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            List {
                if workouts.isEmpty {
                    ContentUnavailableView(
                        "No workouts yet",
                        systemImage: "dumbbell",
                        description: Text("Tap + to log your first workout.")
                    )
                } else {
                    ForEach(workouts) { workout in
                        NavigationLink {
                            WorkoutDetailView(workout: workout)
                        } label: {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(workout.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.headline)
                                if !workout.notes.isEmpty {
                                    Text(workout.notes)
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }
                                Text("\(workout.entries.count) exercise(s)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: deleteWorkouts)
                }
            }
            .navigationTitle("GymLog")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddWorkout = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView()
            }
        }
    }

    private func deleteWorkouts(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(workouts[index])
        }
    }
    private func uniqueExerciseNames() -> [String] {
        Set(workouts.flatMap { $0.entries.map { $0.name } }).sorted()
    }

}

//
//  WorkoutDetailView.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var workout: Workout
    @State private var now = Date()
    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var showingAddExercise = false

    var body: some View {
        List {
            Section("Session") {
                HStack {
                    Text("Elapsed")
                    Spacer()
                    Text(formatHMS(elapsedSeconds))
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }

                HStack(spacing: 12) {
                    Button(workout.startedAt == nil ? "Start Workout" : "Restart") {
                        workout.startedAt = Date()
                        workout.endedAt = nil
                    }
                    .buttonStyle(.borderedProminent)

                    Button("End Workout") {
                        if workout.startedAt == nil {
                            workout.startedAt = Date()
                        }
                        workout.endedAt = Date()
                    }
                    .buttonStyle(.bordered)
                    .disabled(workout.startedAt == nil || workout.endedAt != nil)
                }

                if workout.endedAt != nil {
                    Text("Workout ended.")
                        .foregroundStyle(.secondary)
                } else {
                    Text("Timer starts automatically when you log your first set.")
                        .foregroundStyle(.secondary)
                }
            }
            .onReceive(ticker) { now = $0 }

            Section("Notes") {
                TextField("Notes", text: $workout.notes, axis: .vertical)
                    .lineLimit(1...4)
            }

            Section("Exercises") {
                if workout.entries.isEmpty {
                    Text("No exercises yet. Tap Add Exercise.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(workout.entries) { entry in
                        NavigationLink {
                            ExerciseDetailView(entry: entry)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(entry.name).font(.headline)
                                Text("\(entry.sets.count) set(s)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: deleteEntries)
                }
            }
        }
        .navigationTitle(workout.date.formatted(date: .abbreviated, time: .omitted))
        .toolbar {
            Button("Add Exercise") { showingAddExercise = true }
        }
        .sheet(isPresented: $showingAddExercise) {
            AddExerciseView(workout: workout)
        }
    }

    private func deleteEntries(at offsets: IndexSet) {
        for index in offsets {
            let entry = workout.entries[index]
            workout.entries.remove(at: index)
            modelContext.delete(entry)
        }
    }
    
    private var elapsedSeconds: Int {
        guard let started = workout.startedAt else { return 0 }
        let end = workout.endedAt ?? now
        return max(0, Int(end.timeIntervalSince(started)))
    }


}

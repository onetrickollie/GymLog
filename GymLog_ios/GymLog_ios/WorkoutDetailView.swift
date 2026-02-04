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

    @State private var showingAddExercise = false

    var body: some View {
        List {
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

}

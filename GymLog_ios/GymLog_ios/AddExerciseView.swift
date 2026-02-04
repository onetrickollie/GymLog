//
//  AddExerciseView.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//
import SwiftUI
import SwiftData

struct AddExerciseView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var workout: Workout

    @State private var selectedExercise: String = ""
    @State private var customExerciseName: String = ""

    private var workoutCategory: WorkoutCategory {
        WorkoutCategory(rawValue: workout.category) ?? .push
    }

    private var exercisesForDay: [String] {
        ExerciseCatalog.exercises[workoutCategory] ?? ["Other"]
    }

    private var finalExerciseName: String {
        if selectedExercise == "Other" {
            return customExerciseName.trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            return selectedExercise
        }
    }

    var body: some View {
        NavigationStack {
            Form {
                // Optional: show the day type as read-only context
                Section("Today") {
                    Text(workoutCategory.rawValue)
                        .foregroundStyle(.secondary)
                }

                Section("Exercise") {
                    Picker("Exercise", selection: $selectedExercise) {
                        ForEach(exercisesForDay, id: \.self) { name in
                            Text(name).tag(name)
                        }
                    }

                    if selectedExercise == "Other" {
                        TextField("Custom exercise name", text: $customExerciseName)
                            .textInputAutocapitalization(.words)
                    }
                }
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        guard !finalExerciseName.isEmpty else { return }

                        let entry = ExerciseEntry(name: finalExerciseName, category: workoutCategory, workout: workout)
                        workout.entries.append(entry)
                        dismiss()
                    }
                    .disabled(selectedExercise.isEmpty || (selectedExercise == "Other" && finalExerciseName.isEmpty))
                }
            }
            .onAppear {
                selectedExercise = exercisesForDay.first ?? "Other"
            }
        }
    }
}

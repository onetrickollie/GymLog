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

    @State private var selectedCategory: WorkoutCategory = .push
    @State private var selectedExercise: String = ""
    @State private var customExerciseName: String = ""

    private var exercisesForCategory: [String] {
        ExerciseCatalog.exercises[selectedCategory] ?? []
    }

    var body: some View {
        NavigationStack {
            Form {
                Picker("Category", selection: $selectedCategory) {
                    ForEach(WorkoutCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }

                Picker("Exercise", selection: $selectedExercise) {
                    ForEach(exercisesForCategory, id: \.self) {
                        Text($0)
                    }
                }

                if selectedExercise == "Other" {
                    TextField("Custom exercise name", text: $customExerciseName)
                        .textInputAutocapitalization(.words)
                }
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let finalName =
                            selectedExercise == "Other"
                            ? customExerciseName.trimmingCharacters(in: .whitespacesAndNewlines)
                            : selectedExercise

                        guard !finalName.isEmpty else { return }

                        let entry = ExerciseEntry(
                            name: finalName,
                            category: WorkoutCategory(rawValue: workout.category) ?? .push
                        )
                        workout.entries.append(entry)
                        dismiss()
                    }
                    .disabled(selectedExercise.isEmpty)
                }
            }
            .onAppear {
                selectedExercise = exercisesForCategory.first ?? ""
            }
        }
    }
}

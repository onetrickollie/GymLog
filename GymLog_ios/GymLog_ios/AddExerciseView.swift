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
    @Environment(\.modelContext) private var modelContext

    @Bindable var workout: Workout
    @State private var name: String = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Exercise name (e.g. Bench Press)", text: $name)
                    .textInputAutocapitalization(.words)
            }
            .navigationTitle("Add Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let entry = ExerciseEntry(name: name.trimmingCharacters(in: .whitespacesAndNewlines))
                        guard !entry.name.isEmpty else { return }
                        workout.entries.append(entry)
                        dismiss()
                    }
                }
            }
        }
    }
}

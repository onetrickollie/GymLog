//
//  AddWorkoutView.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import SwiftUI
import SwiftData

struct AddWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var date: Date = .now
    @State private var notes: String = ""

    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Notes (optional)", text: $notes, axis: .vertical)
                    .lineLimit(1...3)
            }
            .navigationTitle("New Workout")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let workout = Workout(date: date, notes: notes)
                        modelContext.insert(workout)
                        dismiss()
                    }
                }
            }
        }
    }
}

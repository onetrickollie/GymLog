//
//  ExerciseDetailView.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import SwiftUI
import SwiftData

struct ExerciseDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var entry: ExerciseEntry

    @State private var weightText: String = ""
    @State private var repsText: String = ""

    var body: some View {
        List {
            Section("Add Set") {
                HStack {
                    TextField("Weight", text: $weightText)
                        .keyboardType(.decimalPad)
                    TextField("Reps", text: $repsText)
                        .keyboardType(.numberPad)
                    Button("Add") {
                        addSet()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }

            Section("Sets") {
                if entry.sets.isEmpty {
                    Text("No sets yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(entry.sets) { s in
                        Text("\(s.weight, specifier: "%.1f") lb × \(s.reps)")
                    }
                    .onDelete(perform: deleteSets)
                }
            }
        }
        .navigationTitle(entry.name)
    }

    private func addSet() {
        let w = Double(weightText) ?? 0
        let r = Int(repsText) ?? 0
        guard w > 0, r > 0 else { return }

        entry.sets.append(WorkoutSet(weight: w, reps: r))
        weightText = ""
        repsText = ""
    }

    private func deleteSets(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(entry.sets[index])
        }
    }
}

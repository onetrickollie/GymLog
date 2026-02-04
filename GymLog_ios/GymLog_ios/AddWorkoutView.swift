import SwiftUI
import SwiftData

struct AddWorkoutView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var date: Date = .now
    @State private var notes: String = ""
    @State private var selectedCategory: WorkoutCategory = .push

    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date, displayedComponents: .date)

                Picker("Workout Type", selection: $selectedCategory) {
                    ForEach(WorkoutCategory.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }

                TextField("Notes (optional)", text: $notes, axis: .vertical)
            }
            .navigationTitle("New Workout")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let workout = Workout(
                            date: date,
                            notes: notes,
                            category: selectedCategory
                        )
                        modelContext.insert(workout)
                        dismiss()
                    }
                }
            }
        }
    }
}

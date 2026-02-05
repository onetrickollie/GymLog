//
//  ProgressView.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/4/26.
//

import SwiftUI
import Charts

struct ProgressView: View {
    let workouts: [Workout]
    @State private var selectedExercise: String = ""

    private var exerciseNames: [String] {
        Array(Set(workouts.flatMap { $0.entries.map { $0.name } })).sorted()
    }

    private var points: [(Date, Double)] {
        workouts
            .sorted { $0.date < $1.date }
            .compactMap { workout in
                let sets = workout.entries
                    .filter { $0.name == selectedExercise }
                    .flatMap { $0.sets }

                guard let best = sets.max(by: { $0.weight < $1.weight }) else { return nil }
                return (workout.date, best.weight)
            }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                Picker("Exercise", selection: $selectedExercise) {
                    ForEach(exerciseNames, id: \.self) { Text($0).tag($0) }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)

                if points.isEmpty {
                    ContentUnavailableView("No data", systemImage: "chart.line.uptrend.xyaxis")
                } else {
                    Chart {
                        ForEach(points, id: \.0) { d, w in
                            LineMark(x: .value("Date", d), y: .value("Weight", w))
                            PointMark(x: .value("Date", d), y: .value("Weight", w))
                        }
                    }
                    .frame(height: 320)
                    .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("Charts")
            .onAppear { selectedExercise = exerciseNames.first ?? "" }
        }
    }
}

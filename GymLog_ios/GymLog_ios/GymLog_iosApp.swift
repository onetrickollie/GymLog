//
//  GymLog_iosApp.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import SwiftUI
import SwiftData

@main
struct GymLog_iosApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Workout.self, ExerciseEntry.self, WorkoutSet.self])
    }
}

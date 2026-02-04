//
//  RestTimerView.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import SwiftUI
import AudioToolbox
import UIKit
struct RestTimerView: View {
    @AppStorage("restSeconds") private var restSeconds: Int = 90

    @State private var remaining: Int = 0
    @State private var isRunning = false

    private let ticker = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var displaySeconds: Int {
        (remaining == 0 && !isRunning) ? restSeconds : remaining
    }
    private func playDoneAlert() {
        // Haptic
        UINotificationFeedbackGenerator().notificationOccurred(.success)

        // System sound (no audio file needed)
        AudioServicesPlaySystemSound(1005)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                Text(formatHMS(displaySeconds))
                    .font(.system(size: 56, weight: .bold, design: .rounded))
                    .monospacedDigit()

                Stepper("Rest: \(restSeconds) sec", value: $restSeconds, in: 10...1200, step: 10)
                    .padding(.horizontal)

                HStack(spacing: 12) {
                    Button(isRunning ? "Pause" : "Start") {
                        if isRunning {
                            isRunning = false
                        } else {
                            if remaining == 0 { remaining = restSeconds }
                            isRunning = true
                        }
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Reset") {
                        isRunning = false
                        remaining = 0
                    }
                    .buttonStyle(.bordered)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Rest Timer")
            .onReceive(ticker) { _ in
                guard isRunning else { return }
                if remaining > 0 {
                    remaining -= 1
                } else {
                    isRunning = false
                    playDoneAlert()
                }
            }
        }
    }
}

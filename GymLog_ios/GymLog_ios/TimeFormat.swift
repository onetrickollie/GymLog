//
//  TimeFormat.swift
//  GymLog_ios
//
//  Created by KaixiangLiu on 2/3/26.
//

import Foundation

func formatHMS(_ seconds: Int) -> String {
    let h = seconds / 3600
    let m = (seconds % 3600) / 60
    let s = seconds % 60

    if h > 0 {
        return String(format: "%d:%02d:%02d", h, m, s)
    } else {
        return String(format: "%d:%02d", m, s)
    }
}

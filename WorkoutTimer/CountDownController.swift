//
//  CountDownController.swift
//  WorkoutTimer
//
//  Created by Hiroki Kayanuma on 2020/06/20.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import Foundation
import SwiftUI


class CountDown: ObservableObject {
    @Published var count = 10
    @Published var interval = 5
    @Published var second = 0
    
    @objc var timer: Timer?
    private var timerInfo: TimerInfo?
    private var str: String?
    init(timerInfoIni: TimerInfo) {
        self.timerInfo = timerInfoIni
    }
    /// if tap start button
    /// - Parameter sender: Any
    func startBt() {
        print("timer: \(self.timerInfo!.setCount).\(self.timerInfo!.second)")
        self.count = self.timerInfo!.setCount
        self.second = self.timerInfo!.second
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
    }
    /// タイマーをカウントダウンする
    @objc func timerUpdate() {
        self.second -= 1
        if self.count == 0 && self.second < 0 {
            self.timer?.invalidate()
            self.resetTimer()
        }
        if self.second < 0 {
            self.second = self.timerInfo!.interval - 1
            self.count -= 1
        }

        print("timer: \(self.count).\(self.second)")
    }
    
    func stopTimer() -> Void {
        self.timer?.invalidate()
    }

    /// タイマーをリセットする
    func resetTimer() {
        self.timerInfo = TimerInfo(interval: 5, setCount: 10, second: 0)
        self.count = self.timerInfo!.setCount
        self.second = self.timerInfo!.second
    }
}

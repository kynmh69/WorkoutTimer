//
//  CountDownController.swift
//  WorkoutTimer
//
//  Created by Hiroki Kayanuma on 2020/06/20.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import Foundation


class CountDown {
    @objc var timer: Timer?
    private var counter = 0
    private var counterSec = 0
    private var timerInfo = TimerInfo(interval: 0, setCount: 0, second: 0)
    
    init(timerInfoIni: TimerInfo) {
        self.timerInfo = timerInfoIni
    }
    /// if tap start button
    /// - Parameter sender: Any
    func startBt() {
        print("timer: \(self.timerInfo.setCount).\(self.timerInfo.second)")
        self.counter = self.timerInfo.setCount
        self.counterSec = self.timerInfo.second
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
    }
    /// タイマーをカウントダウンする
    @objc func timerUpdate() {
        self.counterSec -= 1
        if self.counter == 0 && self.counterSec < 0 {
            self.timer?.invalidate()
            self.resetTimer()
        }
        if self.counterSec < 0 {
            self.counterSec = self.timerInfo.interval - 1
            self.counter -= 1
        }

        print("timer: \(self.counter).\(self.counterSec)")
    }

    /// タイマーをリセットする
    func resetTimer() {
        self.timerInfo = TimerInfo(interval: 5, setCount: 10, second: 0)
        self.counter = self.timerInfo.setCount
        self.counterSec = self.timerInfo.second
    }
}

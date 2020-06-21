//
//  CountDownController.swift
//  WorkoutTimer
//
//  Created by Hiroki Kayanuma on 2020/06/20.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation


class CountDown: ObservableObject {
    @Published var count = 10
    @Published var interval = 5
    @Published var second = 0
    
    @objc var timer: Timer?
    private var timerInfo: TimerInfo?
    private var str: String?
    private let stopMusicPath = Bundle.main.bundleURL.appendingPathComponent("stopMusic.mp3")
    private let countSound =  Bundle.main.bundleURL.appendingPathComponent("cursor2.mp3")
    private var countSoundPlayer: AVAudioPlayer?
    private var musicStop: AVAudioPlayer?
    init(timerInfoIni: TimerInfo) {
        self.timerInfo = timerInfoIni
    }
    /// if tap start button
    /// - Parameter sender: Any
    func startBt() {
        do {
            self.countSoundPlayer = try AVAudioPlayer(contentsOf: countSound, fileTypeHint: "mp3")
            self.musicStop = try AVAudioPlayer(contentsOf: stopMusicPath, fileTypeHint: "mp3")
        } catch  {
            print("error")
        }
        self.countSoundPlayer?.prepareToPlay()
        self.musicStop?.prepareToPlay()
        print("timer: \(self.timerInfo!.setCount).\(self.timerInfo!.second)")
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
    }
    /// タイマーをカウントダウンする
    @objc func timerUpdate() {
        self.second -= 1
        if self.second >= 0 {
            print("play!!")
            self.countSoundPlayer!.play()
        }
        if self.count == 0 && self.second < 0 {
            self.musicStop!.play()
            self.timer?.invalidate()
            self.resetTimer()
        }
        if self.second < 0 {
            self.second = self.interval - 1
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

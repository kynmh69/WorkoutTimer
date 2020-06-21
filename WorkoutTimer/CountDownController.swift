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
    @Published var tempCount = 10
    @Published var blockLock = true
    
    @objc var timer: Timer?
    private var timerInfo: TimerInfo?
    private var str: String?
    private let stopMusicPath = Bundle.main.bundleURL.appendingPathComponent("stopMusic.mp3")
    private let countSound =  Bundle.main.bundleURL.appendingPathComponent("cursor2.mp3")
    private var countSoundPlayer: AVAudioPlayer?
    private var musicStop: AVAudioPlayer?
    init(timerInfoIni: TimerInfo) {
        self.timerInfo = timerInfoIni
        UIApplication.shared.isIdleTimerDisabled = self.blockLock
    }
    /// if tap start button
    /// - Parameter sender: Any
    func startBt() {
        do {
            self.countSoundPlayer = try AVAudioPlayer(contentsOf: countSound, fileTypeHint: "mp3")
            self.musicStop = try AVAudioPlayer(contentsOf: stopMusicPath, fileTypeHint: "mp3")
        } catch  {
//            Alert(title: Text("error"), message: Text("cannnot road sound file."), dismissButton: Alert.Button.cancel())
            print(error)
        }
        self.tempCount = self.count
        self.countSoundPlayer?.prepareToPlay()
        self.musicStop?.prepareToPlay()
        print("timer: \(self.timerInfo!.setCount).\(self.timerInfo!.second)")
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
    }
    /// タイマーをカウントダウンする
    @objc func timerUpdate() {
        // minus 1 sec.
        self.second -= 1
        // play countdown sound.
        self.countSoundPlayer!.play()
        // if end, timer stop and reset.
        if  self.BothLessThanZero(){
            self.musicStop!.play()
            self.timer?.invalidate()
            self.resetTimer()
        }
        if self.secoundLessThanZero() {
            self.second = self.interval - 1
            self.tempCount -= 1
        }

        print("timer: \(self.tempCount).\(self.second)")
    }
    
    func stopTimer() -> Void {
        self.timer?.invalidate()
    }

    /// タイマーをリセットする
    func resetTimer() {
        self.timerInfo = TimerInfo(interval: 5, setCount: 10, second: 0)
        self.tempCount = self.count
        self.second = self.timerInfo!.second
    }
    
    private func secoundLessThanZero() -> Bool {
        if self.second < 0 {
            return true
        } else {
            return false
        }
    }
    
    func BothLessThanZero() -> Bool {
        if self.tempCount == 0 && self.second < 0 {
            return true
        } else {
            return false
        }
    }
}

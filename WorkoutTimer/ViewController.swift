//
//  ViewController.swift
//  WorkoutTimer
//
//  Created by Hiroki Kayanuma on 2020/06/14.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import UIKit

struct TimerInfo {
    var interval: Int
    var setCount: Int
    var second: Int
}


class ViewController: UIViewController {
    @objc var timer: Timer?
    var counter = 0
    var counterSec = 0
    var timerInfo = TimerInfo(interval: 5, setCount: 10, second: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        // set default.
        self.timeLbl.text = "\(self.timerInfo.setCount).\(self.timerInfo.second)"
    }

    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var countField: UITextField!
    
    @IBOutlet weak var intervalField: UITextField!
    
    
    /// if tap start button
    /// - Parameter sender: Any
    @IBAction func startBt(_ sender: Any) {
        self.getFields()
        self.timeLbl.text = "\(self.timerInfo.setCount).\(self.timerInfo.second)"
        print("timer: \(self.timerInfo.setCount).\(self.timerInfo.second)")
        self.counter = self.timerInfo.setCount
        self.counterSec = self.timerInfo.second
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
    }
    
    
    /// if tap stop button
    /// - Parameter sender: Any
    @IBAction func stopBt(_ sender: Any) {
        self.timer?.invalidate()
    }
    
    
    /// if tap reset button
    /// - Parameter sender: Any
    @IBAction func resetBt(_ sender: Any) {
        self.resetTimer()
    }
    
    
    /// フィールドから取得する
    fileprivate func getFields() {
        self.timerInfo.setCount = Int(self.countField.text!) ?? self.timerInfo.setCount
        print("timerInfo.setCount\(self.timerInfo.setCount)")
        self.timerInfo.interval = Int(self.intervalField.text!) ?? self.timerInfo.interval
        print("timerInfo.second: \(self.timerInfo.second)")
        self.intervalField.text?.removeAll()
        self.countField.text?.removeAll()
        self.timeLbl.text = "\(self.timerInfo.setCount).\(self.timerInfo.second)"
    }
    
    /// キーボード以外のところをタップしたら、フィールドの値を取得して閉じる
    /// - Parameters:
    ///   - touches: Set<UITouch>
    ///   - event: UIEvent
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.getFields()

        self.view.endEditing(true)
    }
    
    
    /// タイマーをカウントダウンする
    @objc func timerUpdate() {
        self.counterSec -= 1
        if self.counter == 0 && self.counterSec == 0 {
            self.timer?.invalidate()
            self.resetTimer()
        }
        if self.counterSec < 0 {
            self.counterSec = self.timerInfo.interval
            self.counter -= 1
        }
        
        print("timer: \(self.counter).\(self.counterSec)")
        self.timeLbl.text = "\(self.counter).\(self.counterSec)"
    }
    
    /// タイマーをリセットする
    func resetTimer() {
        self.timerInfo = TimerInfo(interval: 5, setCount: 10, second: 0)
        self.counter = self.timerInfo.setCount
        self.counterSec = self.timerInfo.second
        self.timeLbl.text = "\(self.counter).\(self.counterSec)"
    }
}


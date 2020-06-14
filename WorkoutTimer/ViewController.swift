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
    var timerInfo = TimerInfo(interval: 1, setCount: 10, second: 5)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var timeLbl: UILabel!
    
    @IBAction func startBt(_ sender: Any) {
        self.timeLbl.text = "\(self.timerInfo.setCount).\(self.timerInfo.second)"
        print("timer: \(self.timerInfo.setCount).\(self.timerInfo.second)")
        self.counter = self.timerInfo.setCount
        self.counterSec = self.timerInfo.second
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(self.timerInfo.interval), target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
    }
    @IBAction func stopBt(_ sender: Any) {
        self.timer?.invalidate()
    }
    
    @objc func timerUpdate() {
        self.counterSec -= 1
        if self.counter == 0 && self.counterSec == 0 {
            self.timer?.invalidate()
            self.resetTimer()
        }
        if self.counterSec < 0 {
            self.counterSec = self.timerInfo.second
            self.counter -= 1
        }
        
        print("timer: \(self.counter).\(self.counterSec)")
        self.timeLbl.text = "\(self.counter).\(self.counterSec)"
    }
    
    func resetTimer() {
        self.counter = self.timerInfo.setCount
        self.counterSec = self.timerInfo.second
        self.timeLbl.text = "\(self.counter).\(self.counterSec)"
    }
}


//
//  SwiftUIView.swift
//  WorkoutTimer
//
//  Created by Hiroki Kayanuma on 2020/06/20.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var showTime = "Time"
    @State var showSecondView = false
    @ObservedObject var timeInfo: CountDown
    
//    Set default
    var timeData = TimerInfo(interval: 10, setCount: 5, second: 0)
    var body: some View {
        VStack(alignment: .center) {
//            設定値の表示
            HStack{
                Button(action: {
                    self.showSecondView.toggle()
                }) {
                    CircleButton(text: "i")
                }
            }
            .sheet(isPresented: self.$showSecondView, content: {
                SettingView(isPresent: self.$showSecondView, timeInfo: self.timeInfo)
            })
            HStack(alignment: .center, spacing: 50) {
                Text("Count:   \(self.timeInfo.count)")
                Text("Interval:   \(self.timeInfo.interval)")
            }
            .padding()
            Spacer()
            Text("\(self.timeInfo.count).\(self.timeInfo.second)")
            .font(.largeTitle)
            .fontWeight(.heavy)
            .multilineTextAlignment(.center)
            Spacer()
            ControlButton(timeInfo: timeInfo)
        }
        .padding()
    }
}

struct CircleButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .overlay(Circle().stroke(lineWidth: 2))
    }
}
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(showSecondView: false, timeInfo: CountDown(timerInfoIni: TimerInfo(interval: 5, setCount: 10, second: 0)), timeData: TimerInfo(interval: 5, setCount: 10, second: 0))
    }
}

struct ControlButton: View {
    @ObservedObject var timeInfo: CountDown
    var body: some View {
        Group {
            HStack(alignment: .center, spacing: 60) {
                Button(action: {
                    print("Start")
                    self.timeInfo.startBt()
                }) {
                    CircleButton(text: "Start")
                }
                Button(action: {
                    print("Stop")
                    self.timeInfo.stopTimer()
                }){
                    CircleButton(text: "Stop")
                }
            }
            HStack {
                Button(action: {
                    print("reset")
                    self.timeInfo.resetTimer()
                }) {
                    CircleButton(text: "Reset")
                }
                .foregroundColor(Color.red)
                
            }
        }
    }
}

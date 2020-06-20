//
//  SwiftUIView.swift
//  WorkoutTimer
//
//  Created by Hiroki Kayanuma on 2020/06/20.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {
    @State var count = 0
    @State var interval = 0
    @State var showTime = ""
    
//    Set default
    var timerInfo = TimerInfo(interval: 10, setCount: 5, second: 0)
    var body: some View {
        
        VStack(alignment: .center) {
            NavigationView{
                Form {
                    Picker(selection: $count, label: Text("Count")) {
                        ForEach(3 ..< 30, id: \.self) {
                            num in Text("\(num)")
                        }
                    }
                    Picker(selection: $interval, label: Text("Interval")){
                        ForEach(3 ..< 30, id: \.self) {
                            num in Text("\(num)")
                        }
                    }
                }
            }
            .frame(height: 200.0)
//            設定値の表示
            HStack(alignment: .center, spacing: 40) {
                Text("Count:   \(self.count)")
                Text("Interval:   \(self.interval)")
            }
            .padding()
            Text("Time")
                .font(.largeTitle)
                .bold()
            
            Group {
                HStack(alignment: .center, spacing: 60) {
                    Button(action: {
                        print("Start")
                    }) {
                        Text("Start")
                    }
                    Button(action: {
                        print("Stop")
                    }){
                        Text("Stop")
                    }
                }
                HStack {
                    Button(action: {
                        print("reset")
                    }) {
                        Text("Reset")
                    }.foregroundColor(Color.red)
                }
            }
        }
    .padding()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

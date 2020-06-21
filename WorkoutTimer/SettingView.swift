//
//  SettingView.swift
//  WorkoutTimer
//
//  Created by Hiroki Kayanuma on 2020/06/20.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    @Binding var isPresent: Bool
    @ObservedObject var timeInfo: CountDown

    var body: some View {
        NavigationView{
            Form {
                Picker(selection: self.$timeInfo.count, label: Text("Count")) {
                    ForEach(3 ..< 30, id: \.self) {
                        num in Text("\(num)")
                    }
                }
                Picker(selection: self.$timeInfo.interval, label: Text("Interval")){
                    ForEach(3 ..< 30, id: \.self) {
                        num in Text("\(num)")
                    }
                }
                Toggle("Block unlock", isOn: self.$timeInfo.blockLock)
                
            }
            .navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.isPresent = false
                }, label: {
                    Text("Done")
                })
            )
        }
        
    }
}

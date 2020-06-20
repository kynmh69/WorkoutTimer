//
//  CircleImageView.swift
//  WorkoutTimer
//
//  Created by Hiroki Kayanuma on 2020/06/20.
//  Copyright © 2020 Hiroki Kayanuma. All rights reserved.
//

import SwiftUI

struct CircleImageView: View {
    var body: some View {
        Image("Image")
        .resizable()
        .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 5))
        .shadow(radius: 20)
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
    }
}

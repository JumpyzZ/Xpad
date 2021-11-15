//
//  steeringView.swift
//  XpadIOSClient
//
//  Created by zhu on 2021/11/14.
//

import SwiftUI

struct steeringView: View {
    var tilt: CGFloat
    var limit: CGFloat
    var body: some View {
        ZStack{
            Text("\(Image(systemName: "circle"))")
                .font(.system(size: 250))
                .clipShape(
                    Rectangle()
                        .offset(x: 0, y: -194.4)
                )
                .opacity(0.3)
            Text("\(Image(systemName: "circle"))")
                .foregroundColor((abs(tilt)<limit ? Color.mint : Color.orange))
                .font(.system(size: 250))
                .clipShape(
                    Rectangle()
                        .size(width: 35, height: 60)
                        .offset(x: 129.7, y: 0)
                )
                .rotationEffect(.radians(tilt))
        }.offset(x: 0, y: -30)
    }
}

struct steeringView_Previews: PreviewProvider {
    static var previews: some View {
        steeringView(tilt: 1.05, limit: 1.05)
.previewInterfaceOrientation(.landscapeLeft)
    }
}

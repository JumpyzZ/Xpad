//
//  steeringView.swift
//  XpadIOSClient
//
//  Created by zhu on 2021/11/14.
//

import SwiftUI

struct steeringView: View {
    var tiltTrim: CGFloat
    var limit: CGFloat
    var deadZone: CGFloat

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
                .foregroundColor(abs(tiltTrim)<deadZone ? Color.black.opacity(0.1) : abs(tiltTrim)<limit ? Color.mint:Color.orange)
                .font(.system(size: 250))
                .clipShape(
                    Rectangle()
                        .size(width: 13, height: 60)
                        .offset(x: 141.5, y: 0)
                )
                .rotationEffect(.radians(tiltTrim))
        }.offset(x: 0, y: -30)
    }
}

struct steeringView_Previews: PreviewProvider {
    static var previews: some View {
        steeringView(tiltTrim: 0, limit: 0.8, deadZone: 0.01)
.previewInterfaceOrientation(.landscapeLeft)
    }
}

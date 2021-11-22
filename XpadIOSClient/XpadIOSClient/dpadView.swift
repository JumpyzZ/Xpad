//
//  contorllerView.swift
//  XpadIOSClient
//
//  Created by zhu on 2021/11/12.
//

import SwiftUI
import UIKit

struct buttonAView: View {
    @State var pressed = false
    var body: some View {
        Text("\(Image(systemName: pressed ? "a.circle" : "a.circle.fill"))")
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("A Pressed")
                                    pressed = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<A>Press</A>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("A Released")
                                    pressed = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<A>Release</A>")
                                    }
                                })
                        )
    }
}

struct buttonBView: View {
    @State var pressed = false
    var body: some View {
        Text("\(Image(systemName: pressed ? "b.circle" : "b.circle.fill"))")
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("B Pressed")
                                    pressed = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<B>Press</B>")
                                    }
                                    
                                })
                                .onEnded({ _ in
                                    //print("B Released")
                                    pressed = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<B>Release</B>")
                                    }
                                })
                        )
    }
}

struct buttonXView: View {
    @State var pressed = false
    var body: some View {
        Text("\(Image(systemName: pressed ? "x.circle" : "x.circle.fill"))")
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("X Pressed")
                                    pressed = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<X>Press</X>")
                                    }
                                    
                                })
                                .onEnded({ _ in
                                    //print("X Released")
                                    pressed = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<X>Release</X>")
                                    }
                                })
                        )
    }
}

struct buttonYView: View {
    @State var pressed = false
    var body: some View {
        Text("\(Image(systemName: pressed ? "y.circle" : "y.circle.fill"))")
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("Y Pressed")
                                    pressed = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Y>Press</Y>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("Y Released")
                                    pressed = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Y>Release</Y>")
                                    }
                                })
                        )
    }
}

struct dpadUpTouchView: View {
    @Binding var dpadUp: Bool
    var body: some View {
        Text("\(Image(systemName: "circle.circle"))")
            .opacity(0.001)
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("dpad Up Pressed")
                                    dpadUp = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Up>Press</Up>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("dpad Up Released")
                                    dpadUp = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Up>Release</Up>")
                                    }
                                })
                        )
    }
}

struct dpadDownTouchView: View {
    @Binding var dpadDown: Bool
    var body: some View {
        Text("\(Image(systemName: "circle.circle"))")
            .opacity(0.001)
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("dpad Down Pressed")
                                    dpadDown = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Down>Press</Down>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("dpad Down Released")
                                    dpadDown = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Down>Release</Down>")
                                    }
                                })
                        )
    }
}

struct dpadLeftTouchView: View {
    @Binding var dpadLeft: Bool
    var body: some View {
        Text("\(Image(systemName: "circle.circle"))")
            .opacity(0.001)
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("dpad Left Pressed")
                                    dpadLeft = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Left>Press</Left>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("dpad Left Released")
                                    dpadLeft = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Left>Release</Left>")
                                    }
                                })
                        )
    }
}

struct dpadRightTouchView: View {
    @Binding var dpadRight: Bool
    var body: some View {
        Text("\(Image(systemName: "circle.circle"))")
            .opacity(0.001)
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("dpad Right Pressed")
                                    dpadRight = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Right>Press</Right>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("dpad Right Released")
                                    dpadRight = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Right>Release</Right>")
                                    }
                                })
                        )
    }
}

struct buttonBackView: View {
    @State var pressed = false
    var body: some View {
        Text("\(Image(systemName: pressed ? "rectangle.on.rectangle.circle" : "rectangle.on.rectangle.circle.fill"))")
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("Back Pressed")
                                    pressed = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Back>Press</Back>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("Back Released")
                                    pressed = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Back>Release</Back>")
                                    }
                                })
                        )
    }
}

struct buttonStartView: View {
    @State var pressed = false
    var body: some View {
        Text("\(Image(systemName: pressed ? "line.3.horizontal.circle" : "line.3.horizontal.circle.fill"))")
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("Start Pressed")
                                    pressed = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Start>Press</Start>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("Start Released")
                                    pressed = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<Start>Release</Start>")
                                    }
                                })
                        )
    }
}

struct buttonLBView: View {
    @State var pressed = false
    var body: some View {
        Text("\(Image(systemName: pressed ? "lb.rectangle.roundedbottom" : "lb.rectangle.roundedbottom.fill"))")
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("LB Pressed")
                                    pressed = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<LB>Press</LB>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("LB Released")
                                    pressed = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<LB>Release</LB>")
                                    }
                                })
                        )
    }
}

struct buttonRBView: View {
    @State var pressed = false
    var body: some View {
        Text("\(Image(systemName: pressed ? "rb.rectangle.roundedbottom" : "rb.rectangle.roundedbottom.fill"))")
            .font(.system(size: 40))
            .simultaneousGesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged({ _ in
                                    //print("RB Pressed")
                                    pressed = true
                                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                                    generator.impactOccurred()
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<RB>Press</RB>")
                                    }
                                })
                                .onEnded({ _ in
                                    //print("RB Released")
                                    pressed = false
                                    if globalObj.socket.isConnected{
                                        try! globalObj.socket.write(from: "<RB>Release</RB>")
                                    }
                                })
                        )
    }
}


struct dpadView: View {
    @State var dpadUp = false
    @State var dpadDown = false
    @State var dpadLeft = false
    @State var dpadRight = false

    var body: some View{
        HStack{
            VStack{
                VStack{
                    buttonLBView()
                        .frame(minWidth:100)
                        .contentShape(Rectangle())
                    buttonRBView()
                        .frame(minWidth:100)
                        .contentShape(Rectangle())
                }
                .opacity(0.8)
                ZStack{
                    ZStack{
                        Text("\(Image(systemName: "dpad.up.filled"))")
                            .font(.system(size: 100))
                            .opacity(dpadUp ? 0 : 0.7)
                        
                        Text("\(Image(systemName: "dpad.down.filled"))")
                            .font(.system(size: 100))
                            .opacity(dpadDown ? 0 : 0.7)
                        
                        Text("\(Image(systemName: "dpad.left.filled"))")
                            .font(.system(size: 100))
                            .opacity(dpadLeft ? 0 : 0.7)
                        
                        Text("\(Image(systemName: "dpad.right.filled"))")
                            .font(.system(size: 100))
                            .opacity(dpadRight ? 0 : 0.7)
                    }
                    .padding(.leading)
                    Group{
                        VStack{
                            dpadUpTouchView(dpadUp: $dpadUp).padding(.bottom, 10)
                            dpadDownTouchView(dpadDown: $dpadDown)
                        }
                        HStack{
                            dpadLeftTouchView(dpadLeft: $dpadLeft).padding(.trailing, 20)
                            dpadRightTouchView(dpadRight: $dpadRight)
                        }
                    }
                    .offset(x: 7.9, y: 0)
                    .opacity(0.8)
                }
                Spacer()
            }
            Spacer()
            Group{
                buttonBackView()
                    .opacity(0.8)
                Text("\(Image(systemName: "logo.xbox"))")
                    .font(.system(size: 60))
                    .offset(x: 0, y: -55)
                buttonStartView()
                    .opacity(0.8)
            }
            .offset(x: 31, y: 0)
            Spacer()
            Group{
                VStack{
                    buttonYView().padding(.bottom, 10)
                    buttonAView()
                }
                .offset(x: 108, y: 0)
                HStack{
                    buttonXView().padding(.trailing, 20)
                    buttonBView()
                }
            }
            .opacity(0.8)
            .padding(.trailing)
        }
    }
}
struct contorllerView_Previews: PreviewProvider {
    static var previews: some View {
        dpadView()
.previewInterfaceOrientation(.landscapeRight)
    }
}

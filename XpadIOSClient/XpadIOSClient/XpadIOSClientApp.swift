//
//  XpadIOSClientApp.swift
//  XpadIOSClient
//
//  Created by zhu on 2021/11/10.
//

import SwiftUI
import GameController
import Socket
import CoreMotion

@main
struct XpadIOSClientApp: App {
    let _foo = globalObj.force
    var body: some Scene {
        WindowGroup {
            //backgroundTouchableView()
            //dpadView()
            ContentView()
                //Start collecting gravity data, process to steer data and send to PC client via socket, then pass to view to draw steer visual.
                .environmentObject(steeringData())
        }
    }
}
var globalObj = globalObject()



class globalObject: ObservableObject {
    @Published var socket: Socket
    @Published var force: CGFloat
    
    init(){
        self.socket = try! Socket.create()
        self.force = 0.0
    }
}






class steeringData: ObservableObject{
    @Published var manager: CMMotionManager
    @Published var tilt: CGFloat
    @Published var tiltPercent: CGFloat
    @Published var limit: CGFloat
    @Published var tiltTrim: CGFloat
    @Published var deadZone: CGFloat
    
    
    
    init(){
        self.tilt = 0.0
        // tiltPercent is only used to let PC client know what value to set.
        self.tiltPercent = 0.0
        self.limit = 0.8
        self.tiltTrim = 0.0
        self.deadZone = 0.01
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 0.01
        self.manager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
            self.getMotionData(deviceMotion: motion!)
        })
    }
    
    func getMotionData(deviceMotion: CMDeviceMotion) {
        let xzComponent = sqrt(pow(deviceMotion.gravity.x, 2) + pow(deviceMotion.gravity.z, 2))
        let tilt = atan2(deviceMotion.gravity.y, xzComponent)
        
        self.tilt = tilt
        let limit = self.limit
        self.tiltTrim = (abs(tilt)>limit ? (tilt<0 ? -1 : 1)*limit : tilt)
        self.tiltPercent = self.tiltTrim / self.limit
        
        if globalObj.socket.isConnected{
            let tiltPercentToSend = abs(self.tiltTrim)>self.deadZone ? self.tiltPercent : 0.0
            try! globalObj.socket.write(from: "<Str>\(tiltPercentToSend)</Str>")
        }
    }
}

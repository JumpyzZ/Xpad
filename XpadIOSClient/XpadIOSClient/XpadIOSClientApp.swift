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
    
    
    
    init(){
        self.tilt = 0.0
        self.tiltPercent = 0.0
        self.limit = 1.05
        self.tiltTrim = 0.0
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
            try! globalObj.socket.write(from: "<Str>\(self.tiltPercent)</Str>")
        }
        }
}

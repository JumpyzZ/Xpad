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
import CoreHaptics
import Foundation


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



struct motorData: Decodable{
    let S: Int
    let L: Int
}


class steeringData: ObservableObject{
    @Published var manager: CMMotionManager
    @Published var tilt: CGFloat
    @Published var tiltPercent: CGFloat
    @Published var limit: CGFloat
    @Published var tiltTrim: CGFloat
    @Published var deadZone: CGFloat
    @Published var small_motor: CGFloat
    @Published var large_mortor: CGFloat
    var engine: CHHapticEngine!
    
    var tiltBuffer = [CGFloat](repeating: 0.0, count: 3)
    
    
    
    init(){
        self.tilt = 0.0
        // tiltPercent is only used to let PC client know what value to set.
        self.tiltPercent = 0.0
        self.limit = 0.5
        self.tiltTrim = 0.0
        self.deadZone = 0.06
        self.small_motor = 0.0
        self.large_mortor = 0.0
        self.manager = CMMotionManager()
        self.manager.deviceMotionUpdateInterval = 0.01
        self.manager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
            self.getMotionData(deviceMotion: motion!)
        })
        self.createEngine()
        self.receiveMotor()
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
        
        
        tiltBuffer[2] = tiltBuffer[1]
        tiltBuffer[1] = tiltBuffer[0]
        tiltBuffer[0] = tiltPercent
        
        /*
        if(tiltBuffer[2]<0 && 0<tiltBuffer[0]) || (tiltBuffer[0]<0 && 0<tiltBuffer[2]){
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        
        if abs(tiltTrim)==limit{
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
         */
    }
    
    func receiveMotor(){
        DispatchQueue.global().async {
            while true{
                if globalObj.socket.isConnected {
                    var dat: String? = nil
                    do {
                        dat = try globalObj.socket.readString()
                    }
                    catch{
                        print("Socket disconnected")
                    }
                    do {
                        let jsonString = dat?.data(using: .utf8)
                        if jsonString == nil{
                            continue
                        }
                        let result = try JSONDecoder().decode(motorData.self, from: jsonString!)
                        //Play haptic
                        self.playHapticTransient(time: 0.04, intensity: Float(result.L)/255, sharpness: 0.1)
                        self.playHapticTransient(time: 0.04, intensity: Float(result.S)/255, sharpness: 0.5)
                        if dat != nil{
                            DispatchQueue.main.async {
                                self.large_mortor = CGFloat(result.L)/255
                                self.small_motor = CGFloat(result.S)/255
                            }
                        }
                    }
                    catch {
                        print("Error while parsing.")
                    }
                }
            }
        }
    }
    
    func playHapticTransient(time: TimeInterval, intensity: Float, sharpness: Float) {
        
        // Create an event (static) parameter to represent the haptic's intensity.
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity,
                                                        value: intensity)
        
        // Create an event (static) parameter to represent the haptic's sharpness.
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness,
                                                        value: sharpness)
        
        // Create an event to represent the transient haptic pattern.
        let event = CHHapticEvent(eventType: .hapticTransient,
                                  parameters: [intensityParameter, sharpnessParameter],
                                  relativeTime: 0)
        
        // Create a pattern from the haptic event.
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate) // Play now.
        } catch let error {
            print("Error playing pattern: \(error)")
        }
    }
    
    func createEngine(){
        // Start the haptic engine for the first time.
        do {
            // Create a player to play the haptic pattern.
            engine = try CHHapticEngine()
            // Mute audio to reduce latency for collision haptics.
            engine.playsHapticsOnly = true
            try self.engine.start()
        } catch {
            print("Failed to start the engine: \(error)")
        }
    }
}

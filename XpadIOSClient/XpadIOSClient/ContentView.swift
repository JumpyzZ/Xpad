//
//  ContentView.swift
//  XpadIOSClient
//
//  Created by zhu on 2021/11/10.
//

import SwiftUI
import Socket
import GameController
import CoreMotion

struct ContentView: View {
    @State var isListening = false
    @State var isConnected = false
    @State var i = 0
    
    @EnvironmentObject var stdata: steeringData
    var body: some View {
        VStack{
            ZStack{
                steeringView(tiltTrim: stdata.tiltTrim, limit:stdata.limit, deadZone: stdata.deadZone)
                backgroundTouchableView()
                dpadView()
                VStack{
                    HStack {
                        Button("Start Listen"){
                            if !(isListening || isConnected){
                                let s = globalObj.socket
                                try! s.listen(on: 5050)
                                isListening = s.isListening
                                isConnected = s.isConnected
                            }
                        }
                        Button("Accept Connection"){
                            DispatchQueue.global().async {
                                if self.isListening && !self.isConnected{
                                    let s = globalObj.socket
                                    try! s.acceptConnection()
                                    DispatchQueue.main.async {
                                        self.isListening = s.isListening
                                        self.isConnected = s.isConnected
                                    }
                                }
                            }
                        }
                        Button("Close Connection"){
                            if isConnected{
                                let s = globalObj.socket
                                try! s.write(from: "<SIG>Close Connection</SIG>")
                                s.close()
                                globalObj.socket = try! Socket.create()
                                isListening = globalObj.socket.isListening
                                isConnected = globalObj.socket.isConnected
                            }
                        }
                        HStack{
                            if !(isListening || isConnected){
                                Image(systemName: "bolt.horizontal.circle.fill")
                                    .foregroundColor(.red)
                            }
                            else{
                                if isListening{
                                    Image(systemName: "bolt.horizontal.circle.fill")
                                        .foregroundColor(.yellow)
                                }
                                if isConnected{
                                    Image(systemName: "bolt.horizontal.circle.fill")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}








































































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            if #available(iOS 15.0, *) {
                ContentView()
                    .environmentObject(steeringData())
.previewInterfaceOrientation(.landscapeLeft)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

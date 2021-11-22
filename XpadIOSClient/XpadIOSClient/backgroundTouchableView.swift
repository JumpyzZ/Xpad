//
//  backgroundTouchableView.swift
//  XpadIOSClient
//
//  Created by zhu on 2021/11/13.
//

import SwiftUI
import UIKit

struct backgroundTouchableView: View {
    var body: some View {
        HStack{
            leftTouchableViewContainer()
            rightTouchableViewContainer()
        }
    }
}


struct leftTouchableViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> UIViewType {
        return leftTouchableView(frame: .zero)
    }
    
    func updateUIView(_ uiView: leftTouchableView, context: Context) {}
}

struct rightTouchableViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> UIViewType {
        return rightTouchableView(frame: .zero)
    }
    
    func updateUIView(_ uiView: rightTouchableView, context: Context) {}
}


// MARK: Left section view
class leftTouchableView: UIView {
    var touchViews = [UITouch:TouchSpotView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isMultipleTouchEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Left section pressed")
        for touch in touches {
            createViewForTouch(touch: touch)
        }
    }
 
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       for touch in touches {
           let view = viewForTouch(touch: touch)
           // Move the view to the new location.
           let newLocation = touch.location(in: self)
           let normalizedForce = touch.force / CGFloat(5.555556)
           view?.center = newLocation
           view?.bounds.size = CGSize(width: 130*normalizedForce, height: 130*normalizedForce)
           if globalObj.socket.isConnected{
               try! globalObj.socket.write(from: "<LT>\(normalizedForce)</LT>")
           }
           globalObj.force = normalizedForce
       }
   }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Left section released")
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
        if globalObj.socket.isConnected{
            try! globalObj.socket.write(from: "<LT>\(CGFloat(0.0))</LT>")
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
    }
    
    func createViewForTouch( touch : UITouch ) {
        let newView = TouchSpotView()
        newView.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        newView.center = touch.location(in: self)
        
        // Add the view and animate it to a new size.
        addSubview(newView)
        let normalizedForce = touch.force / touch.maximumPossibleForce
        newView.bounds.size = CGSize(width: 130*normalizedForce, height: 130*normalizedForce)
        
        // Save the views internally
        touchViews[touch] = newView
        
    }
    
    func viewForTouch (touch : UITouch) -> TouchSpotView? {
        return touchViews[touch]
    }
    
    func removeViewForTouch (touch : UITouch ) {
        if let view = touchViews[touch] {
            view.removeFromSuperview()
            touchViews.removeValue(forKey: touch)
        }
    }
}

// MARK: Right section view
class rightTouchableView: UIView {
    var touchViews = [UITouch:TouchSpotView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isMultipleTouchEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Right section pressed")
        for touch in touches {
            createViewForTouch(touch: touch)
        }
    }
 
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       for touch in touches {
           let view = viewForTouch(touch: touch)
           // Move the view to the new location.
           let newLocation = touch.location(in: self)
           let normalizedForce = touch.force / CGFloat(5.555556)
           view?.center = newLocation
           view?.bounds.size = CGSize(width: 130*normalizedForce, height: 130*normalizedForce)
           if globalObj.socket.isConnected{
               try! globalObj.socket.write(from: "<RT>\(normalizedForce)</RT>")
           }
           globalObj.force = normalizedForce
       }
   }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //print("Right section released")
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
        if globalObj.socket.isConnected{
            try! globalObj.socket.write(from: "<RT>\(CGFloat(0.0))</RT>")
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
    }
    
    func createViewForTouch( touch : UITouch ) {
        let newView = TouchSpotView()
        newView.bounds = CGRect(x: 0, y: 0, width: 1, height: 1)
        newView.center = touch.location(in: self)
        
        // Add the view and animate it to a new size.
        addSubview(newView)
        let normalizedForce = touch.force / touch.maximumPossibleForce
        newView.bounds.size = CGSize(width: 130*normalizedForce, height: 130*normalizedForce)
        
        // Save the views internally
        touchViews[touch] = newView
        
    }
    
    func viewForTouch (touch : UITouch) -> TouchSpotView? {
        return touchViews[touch]
    }
    
    func removeViewForTouch (touch : UITouch ) {
        if let view = touchViews[touch] {
            view.removeFromSuperview()
            touchViews.removeValue(forKey: touch)
        }
    }
}
















































class TouchSpotView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   // Update the corner radius when the bounds change.
   override var bounds: CGRect {
       get { return super.bounds }
       set(newBounds) {
           super.bounds = newBounds
           layer.cornerRadius = newBounds.size.width / 2.0
       }
   }
}

























































struct backgroundTouchableView_Previews: PreviewProvider {
    static var previews: some View {
        backgroundTouchableView()
    }
}

//
//  RadialMenuView.swift
//  Snapper
//
//  Created by Kai Azim on 2023-01-24.
//

import SwiftUI
import Defaults

struct RadialMenuView: View {
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    @State private var initialMousePosition: CGPoint = CGPoint()
    @State private var currentAngle:WindowSnappingOptions = .doNothing
    
    @Default(.snapperCornerRadius) var snapperCornerRadius
    @Default(.snapperThickness) var snapperThickness
    @Default(.snapperUsesSystemAccentColor) var snapperUsesSystemAccentColor
    @Default(.snapperAccentColor) var snapperAccentColor
    
    @State private var activeColor = Color(.white)
    @State private var inactiveColor = Color(.clear)
    
    @State var configureMode = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                if (self.snapperCornerRadius < 40) {
                    ZStack {
                        VisualEffectView(material: .hudWindow, blendingMode: .behindWindow)
                        
                        HStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Rectangle()
                                    .frame(width: 100/3, height: 100/3)
                                    .foregroundColor(self.currentAngle == .topLeftQuarter ? activeColor : inactiveColor)
                                
                                Rectangle()
                                    .frame(width: 100/3, height: 100/3)
                                    .foregroundColor(self.currentAngle == .leftHalf ? activeColor : inactiveColor)
                                
                                Rectangle()
                                    .frame(width: 100/3, height: 100/3)
                                    .foregroundColor(self.currentAngle == .bottomLeftQuarter ? activeColor : inactiveColor)
                            }
                            VStack(spacing: 0) {
                                Rectangle()
                                    .frame(width: 100/3, height: 100/3)
                                    .foregroundColor(self.currentAngle == .topHalf ? activeColor : inactiveColor)
                                
                                Spacer()
                                    .frame(width: 100/3, height: 100/3)
                                
                                Rectangle()
                                    .frame(width: 100/3, height: 100/3)
                                    .foregroundColor(self.currentAngle == .bottomHalf ? activeColor : inactiveColor)
                            }
                            VStack(spacing: 0) {
                                Rectangle()
                                    .frame(width: 100/3, height: 100/3)
                                    .foregroundColor(self.currentAngle == .topRightQuarter ? activeColor : inactiveColor)
                                
                                Rectangle()
                                    .frame(width: 100/3, height: 100/3)
                                    .foregroundColor(self.currentAngle == .rightHalf ? activeColor : inactiveColor)
                                
                                Rectangle()
                                    .frame(width: 100/3, height: 100/3)
                                    .foregroundColor(self.currentAngle == .bottomRightQuarter ? activeColor : inactiveColor)
                            }
                        }
                    }
                    .mask(RoundedRectangle(cornerRadius: self.snapperCornerRadius).strokeBorder(.black, lineWidth: self.snapperThickness))
                    .frame(width: 100, height: 100)
                    
                } else {
                    
                    VisualEffectView(material: .hudWindow, blendingMode: .behindWindow)
                        .frame(width: 100, height: 100)
                        .overlay {
                            Path { path in
                                path.move(to: CGPoint(x: 50, y: 50))
                                path.addArc(center: CGPoint(x: 50, y: 50), radius: 90, startAngle: .degrees(22.5), endAngle: .degrees(-22.5), clockwise: true)
                            }
                            .foregroundColor(self.currentAngle == .rightHalf ? activeColor : inactiveColor)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 50, y: 50))
                                path.addArc(center: CGPoint(x: 50, y: 50), radius: 90, startAngle: .degrees(67.5), endAngle: .degrees(22.5), clockwise: true)
                            }
                            .foregroundColor(self.currentAngle == .bottomRightQuarter ? activeColor : inactiveColor)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 50, y: 50))
                                path.addArc(center: CGPoint(x: 50, y: 50), radius: 90, startAngle: .degrees(112.5), endAngle: .degrees(67.5), clockwise: true)
                            }
                            .foregroundColor(self.currentAngle == .bottomHalf ? activeColor : inactiveColor)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 50, y: 50))
                                path.addArc(center: CGPoint(x: 50, y: 50), radius: 90, startAngle: .degrees(157.5), endAngle: .degrees(112.5), clockwise: true)
                            }
                            .foregroundColor(self.currentAngle == .bottomLeftQuarter ? activeColor : inactiveColor)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 50, y: 50))
                                path.addArc(center: CGPoint(x: 50, y: 50), radius: 90, startAngle: .degrees(202.5), endAngle: .degrees(157.5), clockwise: true)
                            }
                            .foregroundColor(self.currentAngle == .leftHalf ? activeColor : inactiveColor)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 50, y: 50))
                                path.addArc(center: CGPoint(x: 50, y: 50), radius: 90, startAngle: .degrees(247.5), endAngle: .degrees(202.5), clockwise: true)
                            }
                            .foregroundColor(self.currentAngle == .topLeftQuarter ? activeColor : inactiveColor)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 50, y: 50))
                                path.addArc(center: CGPoint(x: 50, y: 50), radius: 90, startAngle: .degrees(292.5), endAngle: .degrees(247.5), clockwise: true)
                            }
                            .foregroundColor(self.currentAngle == .topHalf ? activeColor : inactiveColor)
                            
                            Path { path in
                                path.move(to: CGPoint(x: 50, y: 50))
                                path.addArc(center: CGPoint(x: 50, y: 50), radius: 90, startAngle: .degrees(337.5), endAngle: .degrees(292.5), clockwise: true)
                            }
                            .foregroundColor(self.currentAngle == .topRightQuarter ? activeColor : inactiveColor)
                        }
                        .mask(RoundedRectangle(cornerRadius: self.snapperCornerRadius).strokeBorder(.black, lineWidth: self.snapperThickness))
                }
                
                Spacer()
            }
            Spacer()
        }
        .shadow(radius: 10)
        
        .scaleEffect(self.currentAngle == .maximize ? 0.9 : 1)
        .animation(.interpolatingSpring(stiffness: 200, damping: 13), value: self.currentAngle)
        
        .onAppear {
            self.initialMousePosition = CGPoint(x: NSEvent.mouseLocation.x,
                                                y: NSEvent.mouseLocation.y)
            if (self.snapperUsesSystemAccentColor) {
                self.activeColor = Color.accentColor
            } else {
                self.activeColor = self.snapperAccentColor
            }
        }
        .onReceive(timer) { input in
            if (!configureMode) {
                let angleToMouse = Angle(radians: initialMousePosition.angle(to: CGPoint(x: NSEvent.mouseLocation.x, y: NSEvent.mouseLocation.y)))
                let distanceToMouse = initialMousePosition.distance(to: CGPoint(x: NSEvent.mouseLocation.x, y: NSEvent.mouseLocation.y))
                
                if (distanceToMouse > 1000) {
                    self.inactiveColor = Color(.clear)
                    
                    switch Int((angleToMouse.normalized().degrees+45/2)/45) {
                    case 0, 8: self.currentAngle = .rightHalf
                    case 1:    self.currentAngle = .bottomRightQuarter
                    case 2:    self.currentAngle = .bottomHalf
                    case 3:    self.currentAngle = .bottomLeftQuarter
                    case 4:    self.currentAngle = .leftHalf
                    case 5:    self.currentAngle = .topLeftQuarter
                    case 6:    self.currentAngle = .topHalf
                    case 7:    self.currentAngle = .topRightQuarter
                    default:   self.currentAngle = .doNothing
                    }
                } else if (distanceToMouse < 50) {
                    self.currentAngle = .doNothing
                    self.inactiveColor = Color(.clear)
                } else {
                    self.currentAngle = .maximize
                    self.inactiveColor = activeColor
                }
            } else {
                self.currentAngle = .topHalf
            }
        }
        .onChange(of: self.currentAngle) { _ in
            if (!configureMode) {
                NSHapticFeedbackManager.defaultPerformer.perform(
                    NSHapticFeedbackManager.FeedbackPattern.alignment,
                    performanceTime: NSHapticFeedbackManager.PerformanceTime.now
                )
                
                NotificationCenter.default.post(name: Notification.Name.currentSnappingDirectionChanged, object: nil, userInfo: ["Direction": self.currentAngle])
            }
        }
        .onChange(of: self.snapperUsesSystemAccentColor) { _ in
            if (self.snapperUsesSystemAccentColor) {
                self.activeColor = Color.accentColor
            } else {
                self.activeColor = self.snapperAccentColor
            }
        }
        .onChange(of: self.snapperAccentColor) { _ in
            self.activeColor = self.snapperAccentColor
        }
    }
}
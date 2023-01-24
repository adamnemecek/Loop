//
//  WindowResizer.swift
//  WindowManager
//
//  Created by Kai Azim on 2023-01-23.
//

import Cocoa

class WindowResizer {
    func resizeFrontmostWindowWithDirection(_ direction: WindowSnappingOptions) {
        if let screen  = NSScreen.main {
            let screenWidth = screen.frame.width
            let screenHeight = screen.frame.height
            
            print("Window Resized: \(direction)")
            
            switch direction {
            case .north:
                self.resizeFrontmostWindow(CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight/2))
            case .northEast:
                self.resizeFrontmostWindow(CGRect(x: screenWidth/2, y: 0, width: screenWidth/2, height: screenHeight/2))
            case .east:
                self.resizeFrontmostWindow(CGRect(x: screenWidth/2, y: 0, width: screenWidth/2, height: screenHeight))
            case .southEast:
                self.resizeFrontmostWindow(CGRect(x: screenWidth/2, y: screenHeight/2, width: screenWidth/2, height: screenHeight/2))
            case .south:
                self.resizeFrontmostWindow(CGRect(x: 0, y: screenHeight/2, width: screenWidth, height: screenHeight/2))
            case .southWest:
                self.resizeFrontmostWindow(CGRect(x: 0, y: screenHeight/2, width: screenWidth/2, height: screenHeight/2))
            case .west:
                self.resizeFrontmostWindow(CGRect(x: 0, y: 0, width: screenWidth/2, height: screenHeight))
            case .northWest:
                self.resizeFrontmostWindow(CGRect(x: 0, y: 0, width: screenWidth/2, height: screenHeight/2))
            case .maximized:
                self.resizeFrontmostWindow(CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
            case .doNothing:
                return
            }
        }
    }
    
    func resizeFrontmostWindow(_ frame: CGRect) {
        let options = CGWindowListOption(arrayLiteral: .excludeDesktopElements, .optionOnScreenOnly)
        let windowsListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0))
        let windowsList = windowsListInfo as NSArray? as? [[String: AnyObject]]
        let visibleWindows = windowsList?.filter{ $0["kCGWindowLayer"] as! Int == 0 }
        let frontmostWindow = NSWorkspace.shared.frontmostApplication?.localizedName
        
        if let frontmostWindow = frontmostWindow {
            for window in visibleWindows! {
                let owner:String = window["kCGWindowOwnerName"] as! String
                var bounds = window["kCGWindowBounds"] as? [String: Int]
                let pid = window["kCGWindowOwnerPID"] as? Int32
                
                if owner == frontmostWindow {
                    let appRef = AXUIElementCreateApplication(pid!);
                    var value: AnyObject?
                    let result = AXUIElementCopyAttributeValue(appRef, kAXWindowsAttribute as CFString, &value)
                    
                    if let windowList = value as? [AXUIElement] {
//                        print ("windowList #\(windowList)")
                        if let window = windowList.first {
                            var position : CFTypeRef
                            var size : CFTypeRef
                            var newPoint: CGPoint = frame.origin
                            var newSize: CGSize = frame.size
                            
                            size = AXValueCreate(AXValueType(rawValue: kAXValueCGSizeType)!,&newSize)!;
                            position = AXValueCreate(AXValueType(rawValue: kAXValueCGPointType)!,&newPoint)!;
                            
                            AXUIElementSetAttributeValue(windowList.first!, kAXPositionAttribute as CFString, position);
                            AXUIElementSetAttributeValue(windowList.first!, kAXSizeAttribute as CFString, size);
                        }
                    }
                }
            }
        }
    }
}

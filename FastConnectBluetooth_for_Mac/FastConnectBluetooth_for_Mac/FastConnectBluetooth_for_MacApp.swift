//
//  FastConnectBluetooth_for_MacApp.swift
//  FastConnectBluetooth_for_Mac
//
//  Created by hyungjun on 2022/06/01.
//

import SwiftUI
import CoreBluetooth

@main
struct FastConnectBluetooth_for_MacApp: App {
    // Linking App Delegate
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Making it as Pure Menu Bar App


// Setting Up Menu Bar Icon and Menu Bar Popover area
class AppDelegate: NSObject, ObservableObject, NSApplicationDelegate {
    // Properties
    @Published var statusItem: NSStatusItem?
    @Published var popover = NSPopover()
    @Published var menu = NSMenu()
    var connection: Bool = false
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        setUpMacMenu()
    }
    
    func setUpMacMenu() {
        // Popver Properties
        popover.animates = true
        popover.behavior = .transient
        
        // Linking SwiftUI View
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: Home())
        
        // Making it as Key Window
        popover.contentViewController?.view.window?.makeKey()
        
        // Setting Menu Bar Icon and Action
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem?.button {
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(menuButtonAction(sender:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        menu.addItem(NSMenuItem(title: "장치 선택", action: #selector(menuButtonAction(sender:)), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "종료", action: nil, keyEquivalent: ""))
        
    }
    
    @objc func menuButtonAction(sender: AnyObject) {
        let event = NSApp.currentEvent!
        if event.type == NSEvent.EventType.rightMouseUp {
            statusItem?.menu = menu
            statusItem?.button?.performClick(nil)
            statusItem?.menu = nil
            
            /*
            // Showing/Closing Popover
            if popover.isShown {
                popover.close()
            } else {
                if let menuButton = statusItem?.button{
                    popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .minY)
                }
            }
             */
        }
        else {
            if connection {
                connection = false
                print("unconnected")
            }
            else {
                print("connected")
                connection = true
            }
        }
    }
}

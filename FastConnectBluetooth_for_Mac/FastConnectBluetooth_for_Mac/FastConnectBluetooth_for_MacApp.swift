//
//  FastConnectBluetooth_for_MacApp.swift
//  FastConnectBluetooth_for_Mac
//
//  Created by hyungjun on 2022/06/01.
//

import SwiftUI

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
        if let menuButton = statusItem?.button {
            menuButton.image = .init(systemSymbolName: "dollarsign.circle.fill", accessibilityDescription: nil)
            //menuButton.action = #selector(menuButtonAction(sender:))
            menu.addItem(NSMenuItem(title: "장치 선택", action: #selector(menuButtonAction(sender:)), keyEquivalent: ""))
            menu.addItem(NSMenuItem(title: "종료", action: nil, keyEquivalent: ""))
            statusItem?.menu = menu
        }
        
    }
    
    @objc func menuButtonAction(sender: AnyObject) {
        // Showing/Closing Popover
        if popover.isShown {
            popover.close()
        } else {
            if let menuButton = statusItem?.button{
                popover.show(relativeTo: menuButton.bounds, of: menuButton, preferredEdge: .minY)
            }
        }
    }
}

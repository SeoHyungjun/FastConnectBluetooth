//
//  AppDelegate.swift
//  FastConnectBluetooth_for_Mac
//
//  Created by hyungjun on 2022/05/20.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    var connection: Bool = false

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(togglePopover(_:))
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }
        popover.behavior = NSPopover.Behavior.transient // 팝오버가 아닌 다른곳 클릭시 팝오버 끄기
        popover.contentViewController = SampleViewController.freshController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
    
    @objc func togglePopover(_ sender: Any?) {
        let event = NSApp.currentEvent!
        if event.type == NSEvent.EventType.rightMouseUp { // 우클릭 액션
            if popover.isShown {
                closePopover(sender: sender)
            } else {
                showPopover(sender: sender)
            }
        } else { // 좌클릭 액션
            print("Left Click")
            if connection {
                connection = false
                print("unConnected")
            } else {
                connection = true
                print("Connected")
            }
                    
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.maxY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }


}


//
//  AppDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let mainWindowController = MainWindowController()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        mainWindowController.windowFrameAutosaveName = NSWindow.FrameAutosaveName(rawValue: "main")
        mainWindowController.window?.makeKeyAndOrderFront(nil)
    }

}


//
//  WindowController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 19/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    private let container = ViewController()

    var mainViewController: NSViewController? {
        get {
            return container.childViewControllers.last
        }
        set {
            container.removeChildren()
            if let viewController = newValue {
                container.addMainChildViewController(viewController)
            }
        }
    }

    var windowMask: NSWindow.StyleMask {
        return [.titled, .closable, .miniaturizable, .resizable]
    }

    init() {
        super.init(window: NSWindow())
        window?.styleMask = windowMask

        contentViewController = container
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

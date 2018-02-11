//
//  MainWindowController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 02/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class MainWindowController: WindowController {

    override var windowMask: NSWindow.StyleMask {
        return [.titled, .miniaturizable]
    }

    lazy var dragAndDropViewController: DragAndDropViewController = {
        let controller = DragAndDropViewController()
        controller.delegate = self
        return controller
    }()

    lazy var eventsWindowControllers = [EventsWindowController]()

    lazy var processingViewController = ProcessingViewController()

    lazy var processingWindowController: WindowController = {
        let windowController = WindowController()
        windowController.mainViewController = self.processingViewController
        return windowController
    }()

    lazy var copyHandler = CopyHandler()

    override init() {
        super.init()

        window?.center()

        mainViewController = dragAndDropViewController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func processing(_ count: Int, of total: Int) {
        processingViewController.hint = "Processing \(count + 1) of \(total)"
        processingViewController.progress = Double(count + 1) / Double(total)
    }

}

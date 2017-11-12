//
//  EventsWindowController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class EventsWindowController: NSWindowController {

    private let container = ViewController()
    private let processingViewController = ProcessingViewController()

    init() {
        super.init(window: NSWindow())

        container.addMainChildViewController(processingViewController)
        contentViewController = container
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Processing

    func processing() {
        processingViewController.hint = "Processing…"
    }

    func processing(_ count: Int, of total: Int) {
        processingViewController.hint = "Processing \(count + 1) of \(total)"
        processingViewController.progress = Double(count + 1) / Double(total)
    }

    // Event

    func show(event: Event) {
        guard let controller = EventViewController(event: event) else {
            return
        }

        container.removeChildren()
        container.addMainChildViewController(controller)
    }

}

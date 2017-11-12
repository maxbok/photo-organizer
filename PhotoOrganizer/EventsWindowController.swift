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

    private lazy var eventViewController: EventViewController = {
        let controller = EventViewController()
        controller.delegate = self
        return controller
    }()

    var events = [Event]() {
        didSet {
            eventIndex = 0
        }
    }

    private(set) var eventIndex = 0

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
        if processingViewController.parent == nil {
            container.removeChildren()
            container.addMainChildViewController(processingViewController)
        }
        processingViewController.hint = "Processing…"
        processingViewController.progress = nil
    }

    func processing(_ count: Int, of total: Int) {
        processingViewController.hint = "Processing \(count + 1) of \(total)"
        processingViewController.progress = Double(count + 1) / Double(total)
    }

    // Event

    func show(events: [Event]) {
        self.events = events

        container.removeChildren()
        container.addMainChildViewController(eventViewController)

        showNextEvent()
    }

    func showNextEvent() {
        eventViewController.show(event: events[eventIndex], index: eventIndex, total: events.count)
        eventIndex += 1
    }

}

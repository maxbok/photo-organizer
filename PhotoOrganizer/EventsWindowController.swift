//
//  EventsWindowController.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

class EventsWindowController: WindowController {

    weak var delegate: EventsWindowControllerDelegate?

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

    override init() {
        super.init()

        window?.center()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Event

    func show(events: [Event]) {
        self.events = events
        mainViewController = eventViewController
        showNextEvent()
    }

    func showNextEvent() {
        eventViewController.show(event: events[eventIndex], index: eventIndex, total: events.count)
        eventIndex += 1
    }

}

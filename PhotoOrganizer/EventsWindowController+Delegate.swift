//
//  EventsWindowController+Delegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 12/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


extension EventsWindowController: EventViewControllerDelegate {

    func eventNamed() {
        if events.count > eventIndex {
            showNextEvent()
        } else {
            delegate?.eventsWindowController(self, named: events)
            close()
        }
    }

}

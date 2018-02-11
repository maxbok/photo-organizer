//
//  MainWindowController+EventsWindowControllerDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 27/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


extension MainWindowController: EventsWindowControllerDelegate {

    func eventsWindowController(_ controller: EventsWindowController, named events: [Event]) {
        copyHandler.copy(
            events: events,
            with: Settings.shared,
            progress: { count, total in
                print("count: \(count) - total: \(total)")
        }) {
            print("completed copy")
        }
    }

}

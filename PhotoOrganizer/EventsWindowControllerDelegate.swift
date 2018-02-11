//
//  EventsWindowControllerDelegate.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 27/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


protocol EventsWindowControllerDelegate: class {

    func eventsWindowController(_ controller: EventsWindowController, named events: [Event])

}

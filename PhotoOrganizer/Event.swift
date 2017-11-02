//
//  Event.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa


class Event {

    var name: String?
    private(set) var days: [EventDay]
    var hasSingleDay: Bool {
        return days.count == 1
    }

    init(days: [EventDay] = []) {
        self.days = days
    }

    func add(eventDay: EventDay) {
        days.append(eventDay)
    }

}

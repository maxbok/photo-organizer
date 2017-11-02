//
//  Event+Generator.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 01/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Foundation


extension Event {

    static func from(files: [URL]) -> [Event] {
        var missingCreationDateFiles = [URL]()
        var eventDays = [EventDay]()

        for file in files {
            guard let date = file.creationDate else {
                missingCreationDateFiles.append(file)
                continue
            }

            let eventDay: EventDay

            if let index = eventDays.index(where: { date.sameDay(as: $0.date) }) {
                eventDay = eventDays[index]
            } else {
                eventDay = EventDay(date: date)
                eventDays.append(eventDay)
            }

            eventDay.files.append(File(originalPath: file.path))
        }

        return events(from: eventDays)
    }

    private static func events(from eventDays: [EventDay]) -> [Event] {
        let eventDays = eventDays.sorted(by: { $0.0.date.compare($0.1.date) == .orderedAscending })

        var events = [Event]()
        var currentEvent: Event?
        var lastDate: Date?

        for day in eventDays {
            guard   let date = lastDate,
                    date.days(to: day.date) == 1
            else {
                lastDate = day.date
                let event = Event()
                event.add(eventDay: day)
                events.append(event)
                currentEvent = event
                continue
            }

            currentEvent?.add(eventDay: day)
            lastDate = day.date
        }

        return events
    }

}

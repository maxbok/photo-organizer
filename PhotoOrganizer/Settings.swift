//
//  Settings.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import Cocoa

let DefaultOutputFolderPath = "~/PhotoOrganizer"

struct Settings {

    var outputFolderPath: String
    var keepOriginals: Bool
    let eventDateFormatter: DateFormatter
    let eventMultipleDateFormatter: DateFormatter
    let eventDayFormatter: DateFormatter

    static var shared: Settings = {
        let eventFormatter = DateFormatter()
        eventFormatter.dateFormat = "yyyyMMdd"

        let eventDayFormatter = DateFormatter()
        eventDayFormatter.dateFormat = "yy-MM-dd"

        return Settings(eventDateFormatter: eventFormatter, eventDayFormatter: eventDayFormatter)
    }()

    init(eventDateFormatter: DateFormatter, eventDayFormatter: DateFormatter, outputFolderPath: String = DefaultOutputFolderPath, keepOriginals: Bool = true) {
        self.eventDateFormatter = eventDateFormatter
        let formatter = DateFormatter()
        formatter.dateFormat = eventDateFormatter.dateFormat.replacingOccurrences(of: "dd", with: "00")
        self.eventMultipleDateFormatter = formatter
        self.eventDayFormatter = eventDayFormatter
        self.outputFolderPath = outputFolderPath
        self.keepOriginals = keepOriginals
    }

    func relativePathToFolder(for event: Event, on eventDay: EventDay) -> String {
        let dateString: String
        if event.hasSingleDay {
            dateString = eventDateFormatter.string(from: eventDay.date)
        } else {
            dateString = eventMultipleDateFormatter.string(from: eventDay.date)
        }

        let eventPath: String
        if let name = event.name {
            eventPath = "\(dateString) \(name)"
        } else {
            eventPath = dateString
        }

        if event.hasSingleDay {
            return "\(eventPath)"
        }

        let dayPath = eventDayFormatter.string(from: eventDay.date)
        return "\(eventPath)/\(dayPath)"
    }

}

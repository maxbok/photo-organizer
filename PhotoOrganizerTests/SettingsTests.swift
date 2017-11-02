//
//  SettingsTests.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 28/10/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import XCTest
@testable import PhotoOrganizer


class SettingsTests: XCTestCase {

    lazy var settings: Settings = {
        let eventFormatter = DateFormatter()
        eventFormatter.dateFormat = "yyyyMMdd"

        let eventDayFormatter = DateFormatter()
        eventDayFormatter.dateFormat = "yy-MM-dd"

        return Settings(eventDateFormatter: eventFormatter, eventDayFormatter: eventDayFormatter)
    }()

    func testRelativePathSingleDateWithoutEventName() {
        let eventDay = eventDayWith(year: 2017, month: 5, day: 16)
        let event = Event(days: [eventDay])

        let file = File(originalPath: "test/path/file_name.png")

        XCTAssertEqual(settings.relativePath(for: event, on: eventDay, with: file), "20170516/file_name.png")
    }

    func testRelativePathSingleDate() {
        let eventDay = eventDayWith(year: 2017, month: 5, day: 16)
        let event = Event(days: [eventDay])
        event.name = "Test event name"

        let file = File(originalPath: "test/path/file_name.png")

        let path = settings.relativePath(for: event, on: eventDay, with: file)
        XCTAssertEqual(path, "20170516 Test event name/file_name.png")
    }

    func testRelativePathMultipleDatesWithoutEventName() {
        let eventDay1 = eventDayWith(year: 2017, month: 5, day: 16)
        let eventDay2 = eventDayWith(year: 2017, month: 5, day: 17)

        let event = Event(days: [eventDay1, eventDay2])

        let file = File(originalPath: "test/path/file_name.png")

        let path1 = settings.relativePath(for: event, on: eventDay1, with: file)
        XCTAssertEqual(path1, "20170500/17-05-16/file_name.png")
        let path2 = settings.relativePath(for: event, on: eventDay2, with: file)
        XCTAssertEqual(path2, "20170500/17-05-17/file_name.png")
    }

    func testRelativePathMultipleDates() {
        let eventDay1 = eventDayWith(year: 2017, month: 5, day: 16)
        let eventDay2 = eventDayWith(year: 2017, month: 5, day: 17)

        let event = Event(days: [eventDay1, eventDay2])
        event.name = "Test event name"

        let file = File(originalPath: "test/path/file_name.png")

        let path1 = settings.relativePath(for: event, on: eventDay1, with: file)
        XCTAssertEqual(path1, "20170500 Test event name/17-05-16/file_name.png")
        let path2 = settings.relativePath(for: event, on: eventDay2, with: file)
        XCTAssertEqual(path2, "20170500 Test event name/17-05-17/file_name.png")
    }

    private func eventDayWith(year: Int, month: Int, day: Int) -> EventDay {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day

        let date = Calendar.current.date(from: components)!
        return EventDay(date: date)
    }

}

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

        XCTAssertEqual(settings.relativePathToFolder(for: event, on: eventDay), "20170516")
    }

    func testRelativePathSingleDate() {
        let eventDay = eventDayWith(year: 2017, month: 5, day: 16)
        let event = Event(days: [eventDay])
        event.name = "Test event name"

        let path = settings.relativePathToFolder(for: event, on: eventDay)
        XCTAssertEqual(path, "20170516 Test event name")
    }

    func testRelativePathMultipleDatesWithoutEventName() {
        let eventDay1 = eventDayWith(year: 2017, month: 5, day: 16)
        let eventDay2 = eventDayWith(year: 2017, month: 5, day: 17)

        let event = Event(days: [eventDay1, eventDay2])

        let path1 = settings.relativePathToFolder(for: event, on: eventDay1)
        XCTAssertEqual(path1, "20170500/17-05-16")
        let path2 = settings.relativePathToFolder(for: event, on: eventDay2)
        XCTAssertEqual(path2, "20170500/17-05-17")
    }

    func testRelativePathMultipleDates() {
        let eventDay1 = eventDayWith(year: 2017, month: 5, day: 16)
        let eventDay2 = eventDayWith(year: 2017, month: 5, day: 17)

        let event = Event(days: [eventDay1, eventDay2])
        event.name = "Test event name"

        let path1 = settings.relativePathToFolder(for: event, on: eventDay1)
        XCTAssertEqual(path1, "20170500 Test event name/17-05-16")
        let path2 = settings.relativePathToFolder(for: event, on: eventDay2)
        XCTAssertEqual(path2, "20170500 Test event name/17-05-17")
    }

    func testRelativePathMultipleDatesOverlappingMonths() {
        let eventDay1 = eventDayWith(year: 2017, month: 11, day: 30)
        let eventDay2 = eventDayWith(year: 2017, month: 12, day: 1)

        let event = Event(days: [eventDay1, eventDay2])
        event.name = "Test event name"

        let path1 = settings.relativePathToFolder(for: event, on: eventDay1)
        XCTAssertEqual(path1, "20171100 Test event name/17-11-30")
        let path2 = settings.relativePathToFolder(for: event, on: eventDay2)
        XCTAssertEqual(path2, "20171100 Test event name/17-12-01")
    }

    func testRelativePathMultipleDatesOverlappingYears() {
        let eventDay1 = eventDayWith(year: 2017, month: 12, day: 31)
        let eventDay2 = eventDayWith(year: 2018, month: 1, day: 1)

        let event = Event(days: [eventDay1, eventDay2])
        event.name = "Test event name"

        let path1 = settings.relativePathToFolder(for: event, on: eventDay1)
        XCTAssertEqual(path1, "20171200 Test event name/17-12-31")
        let path2 = settings.relativePathToFolder(for: event, on: eventDay2)
        XCTAssertEqual(path2, "20171200 Test event name/18-01-01")
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

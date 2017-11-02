//
//  DateTests.swift
//  PhotoOrganizer
//
//  Created by Maxime Bokobza on 01/11/2017.
//  Copyright © 2017 Codehawks. All rights reserved.
//

import XCTest
@testable import PhotoOrganizer


class DateTests: XCTestCase {

    let calendar = Calendar.current

    func testSameDay() {
        let comp1 = components(year: 2017, month: 10, day: 4, hour: 10)
        let date1 = calendar.date(from: comp1)

        let comp2 = components(year: 2017, month: 10, day: 4, hour: 20)
        let date2 = calendar.date(from: comp2)

        XCTAssertTrue(date1!.sameDay(as: date2!))
}

    func testAnotherDay() {
        let comp1 = components(year: 2017, month: 10, day: 4, hour: 10)
        let date1 = calendar.date(from: comp1)

        let comp2 = components(year: 2017, month: 10, day: 5, hour: 7)
        let date2 = calendar.date(from: comp2)

        XCTAssertFalse(date1!.sameDay(as: date2!))
    }

    func testDaysCount() {
        let comp1 = components(year: 2016, month: 12, day: 29, hour: 10)
        let date1 = calendar.date(from: comp1)

        let comp2 = components(year: 2017, month: 1, day: 5, hour: 7)
        let date2 = calendar.date(from: comp2)

        XCTAssertEqual(date1!.days(to: date2!), 7)
    }

    func components(year: Int, month: Int, day: Int, hour: Int) -> DateComponents {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour

        return components
    }

}
